import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp/model/SymptomProfile.dart';
import 'package:mvp/model/Transcript.dart';
import 'package:http/http.dart' as http;
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, required this.audioID});

  final String audioID;

  // final QuectoAction task;
  // final Map payload;

  // final String taskID;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _readyToGo = false;
  SymptomProfile _symptomProfile = SymptomProfile(symptom2location: {});
  @override
  void initState() {
    super.initState();

    String purifiedTranscript = "";
    Transcript transcript = Transcript(transcriptURL: "");
    List<String> symptoms = [];
    Map<String, List<String>> symptomLocations = {};

    Future.delayed(
      Duration(seconds: 3),
      () async {
        final response = await createTranscription(widget.audioID);

        String selfInfo = jsonDecode(response.body)["self"];

        var slashPos = selfInfo.lastIndexOf('/');
        String transcriptionID = (slashPos != -1)
            ? selfInfo.substring(slashPos, selfInfo.length)
            : selfInfo;
        print("Transcription ID: ${transcriptionID}");

        while (await checkTranscriptionStatus(transcriptionID) != "Succeeded") {
          Future.delayed(Duration(seconds: 3));
        }

        final transcriptURL = await getTranscriptURL(transcriptionID);
        transcript = Transcript(
          transcriptURL: transcriptURL,
        );
        purifiedTranscript =
            await transcript.getPurifiedTranscript(transcript.transcriptURL);
        symptoms = await transcriptToSymptoms(purifiedTranscript);
      },
    ).whenComplete(() async {
      symptomLocations = await symptomLocate(symptoms);
      print("before routing: ${symptomLocations.toString()}");
      context.go('/profiling', extra: symptomLocations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RippleAnimation(
        child: SizedBox.shrink(),
        repeat: true,
      ),
    );
  }

  Future<String> getTranscriptURL(String transcriptionID) async {
    String url =
        "https://eastus.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions/${transcriptionID}/files";
    final header = {
      'Ocp-Apim-Subscription-Key': 'd0fb21013c3e4caf845c60cffeabc30f',
    };
    final response = await http.get(Uri.parse(url), headers: header);

    final result = jsonDecode(response.body);

    return result["values"][0]["links"]["contentUrl"];
  }

  Future<String> checkTranscriptionStatus(String transcriptionID) async {
    String url =
        "https://eastus.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions/${transcriptionID}";
    final header = {
      'Ocp-Apim-Subscription-Key': 'd0fb21013c3e4caf845c60cffeabc30f',
    };
    final response = await http.get(Uri.parse(url), headers: header);
    print("Checking job status: ${response.body}");
    return jsonDecode(response.body)["status"].toString();
  }

  Future<http.Response> createTranscription(String ID) async {
    String url =
        'https://eastus.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions';
    final headers = {
      'Ocp-Apim-Subscription-Key': 'd0fb21013c3e4caf845c60cffeabc30f',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'displayName': '${ID}',
      'description': 'Speech Studio Batch speech to text',
      'locale': 'en-us',
      'contentUrls': [
        'https://quectoclientrepo.blob.core.windows.net/scribe-audio/${ID}.mp3',
      ],
      'model': {
        'self':
            'https://eastus.api.cognitive.microsoft.com/speechtotext/v3.2-preview.1/models/base/32a18586-1b16-49dd-8f51-e25550331a2f',
      },
      'properties': {
        'wordLevelTimestampsEnabled': false,
        'displayFormWordLevelTimestampsEnabled': true,
        'diarizationEnabled': false,
        'punctuationMode': 'DictatedAndAutomatic',
        'profanityFilterMode': 'Masked',
      },
      'customProperties': {},
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      print('Request successful!'); // Handle the response as needed
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
    return response;
  }

  Future<List<String>> transcriptToSymptoms(String transcript) async {
    var model_url =
        "https://quectollm.openai.azure.com/openai/deployments/quectoprofiling/chat/completions?api-version=2023-07-01-preview";
    var headers = {
      'Content-Type': 'application/json',
      'api-key': "31f4ac62df474e1793542a6671805904",
    };

    var body = jsonEncode({
      "messages": [
        {
          "role": "system",
          "content":
              "You are a clinical assistant who analyzes symptoms and experiences patients are experiencing through the conversation between physicians and patients. You will summarize the symptoms by listing the matching symptoms only from the following list, described by patients:\nanxiety and nervousness\ndepression\nshortness of breath\ndepressive or psychotic symptoms\nsharp chest pain\ndizziness\ninsomnia\nabnormal involuntary movements\nchest tightness\npalpitations\nirregular heartbeat\nbreathing fast\nhoarse voice\nsore throat\ndifficulty speaking\ncough\nnasal congestion\nthroat swelling\ndiminished hearing\nlump in throat\nthroat feels tight\ndifficulty in swallowing\nskin swelling\nretention of urine\ngroin mass\nleg pain\nhip pain\nsuprapubic pain\nblood in stool\nlack of growth\nemotional symptoms\nelbow weakness\nback weakness\npus in sputum\nsymptoms of the scrotum and testes\nswelling of scrotum\npain in testicles\nflatulence\npus draining from ear\njaundice\nmass in scrotum\nwhite discharge from eye\nirritable infant\nabusing alcohol\nfainting\nhostile behavior\ndrug abuse\nsharp abdominal pain\nfeeling ill\nvomiting\nheadache\nnausea\ndiarrhea\nvaginal itching\nvaginal dryness\npainful urination\ninvoluntary urination\npain during intercourse\nfrequent urination\nlower abdominal pain\nvaginal discharge\nblood in urine\nhot flashes\nintermenstrual bleeding\nhand or finger pain\nwrist pain\nhand or finger swelling\narm pain\nwrist swelling\narm stiffness or tightness\narm swelling\nhand or finger stiffness or tightness\nwrist stiffness or tightness\nlip swelling\ntoothache\nabnormal appearing skin\nskin lesion\nacne or pimples\ndry lips\nfacial pain\nmouth ulcer\nskin growth\neye deviation\ndiminished vision\ndouble vision\ncross-eyed\nsymptoms of eye\npain in eye\neye moves abnormally\nabnormal movement of eyelid\nforeign body sensation in eye\nirregular appearing scalp\nswollen lymph nodes\nback pain\nneck pain\nlow back pain\npain of the anus\npain during pregnancy\npelvic pain\nimpotence\ninfant spitting up\nvomiting blood\nregurgitation\nburning abdominal pain\nrestlessness\nsymptoms of infants\nwheezing\nperipheral edema\nneck mass\near pain\njaw swelling\nmouth dryness\nneck swelling\nknee pain\nfoot or toe pain\nbowlegged or knock-kneed\nankle pain\nbones are painful\nknee weakness\nelbow pain\nknee swelling\nskin moles\nknee lump or mass\nweight gain\nproblems with movement\nknee stiffness or tightness\nleg swelling\nfoot or toe swelling\nheartburn\nsmoking problems\nmuscle pain\ninfant feeding problem\nrecent weight loss\nproblems with shape or size of breast\nunderweight\ndifficulty eating\nscanty menstrual flow\nvaginal pain\nvaginal redness\nvulvar irritation\nweakness\ndecreased heart rate\nincreased heart rate\nbleeding or discharge from nipple\nringing in ear\nplugged feeling in ear\nitchy ear(s)\nfrontal headache\nfluid in ear\nneck stiffness or tightness\nspots or clouds in vision\neye redness\nlacrimation\nitchiness of eye\nblindness\neye burns or stings\nitchy eyelid\nfeeling cold\ndecreased appetite\nexcessive appetite\nexcessive anger\nloss of sensation\nfocal weakness\nslurring words\nsymptoms of the face\ndisturbance of memory\nparesthesia\nside pain\nfever\nshoulder pain\nshoulder stiffness or tightness\nshoulder weakness\narm cramps or spasms\nshoulder swelling\ntongue lesions\nleg cramps or spasms\nabnormal appearing tongue\nache all over\nlower body pain\nproblems during pregnancy\nspotting or bleeding during pregnancy\ncramps and spasms\nupper abdominal pain\nstomach bloating\nchanges in stool appearance\nunusual color or odor to urine\nkidney mass\nswollen abdomen\nsymptoms of prostate\nleg stiffness or tightness\ndifficulty breathing\nrib pain\njoint pain\nmuscle stiffness or tightness\npallor\nhand or finger lump or mass\nchills\ngroin pain\nfatigue\nabdominal distention\nregurgitation.1\nsymptoms of the kidneys\nmelena\nflushing\ncoughing up sputum\nseizures\ndelusions or hallucinations\nshoulder cramps or spasms\njoint stiffness or tightness\npain or soreness of breast\nexcessive urination at night\nbleeding from eye\nrectal bleeding\nconstipation\ntemper problems\ncoryza\nwrist weakness\neye strain\nhemoptysis\nlymphedema\nskin on leg or foot looks infected\nallergic reaction\ncongestion in chest\nmuscle swelling\npus in urine\nabnormal size or shape of ear\nlow back weakness\nsleepiness\napnea\nabnormal breathing sounds\nexcessive growth\nelbow cramps or spasms\nfeeling hot and cold\nblood clots during menstrual periods\nabsence of menstruation\npulling at ears\ngum pain\nredness in ear\nfluid retention\nflu-like syndrome\nsinus congestion\npainful sinuses\nfears and phobias\nrecent pregnancy\nuterine contractions\nburning chest pain\nback cramps or spasms\nstiffness all over\nmuscle cramps, contractures, or spasms\nlow back cramps or spasms\nback mass or lump\nnosebleed\nlong menstrual periods\nheavy menstrual flow\nunpredictable menstruation\npainful menstruation\ninfertility\nfrequent menstruation\nsweating\nmass on eyelid\nswollen eye\neyelid swelling\neyelid lesion or rash\nunwanted hair\nsymptoms of bladder\nirregular appearing nails\nitching of skin\nhurts to breath\nnailbiting\nskin dryness, peeling, scaliness, or roughness\nskin on arm or hand looks infected\nskin irritation\nitchy scalp\nhip swelling\nincontinence of stool\nfoot or toe cramps or spasms\nwarts\nbumps on penis\ntoo little hair\nfoot or toe lump or mass\nskin rash\nmass or swelling around the anus\nlow back swelling\nankle swelling\nhip lump or mass\ndrainage in throat\ndry or flaky scalp\npremenstrual tension or irritability\nfeeling hot\nfeet turned in\nfoot or toe stiffness or tightness\npelvic pressure\nelbow swelling\nelbow stiffness or tightness\nearly or late onset of menopause\nmass on ear\nbleeding from ear\nhand or finger weakness\nlow self-esteem\nthroat irritation\nitching of the anus\nswollen or red tonsils\nirregular belly button\nswollen tongue\nlip sore\nvulvar sore\nhip stiffness or tightness\nmouth pain\narm weakness\nleg lump or mass\ndisturbance of smell or taste\ndischarge in stools\npenis pain\nloss of sex drive\nobsessions and compulsions\nantisocial behavior\nneck cramps or spasms\npupils unequal\npoor circulation\nthirst\nsleepwalking\nskin oiliness\nsneezing\nbladder mass\nknee cramps or spasms\npremature ejaculation\nleg weakness\nposture problems\nbleeding in mouth\ntongue bleeding\nchange in skin mole size or color\npenis redness\npenile discharge\nshoulder lump or mass\npolyuria\ncloudy eye\nhysterical behavior\narm lump or mass\nnightmares\nbleeding gums\npain in gums\nbedwetting\ndiaper rash\nlump or mass of breast\nvaginal bleeding after menopause\ninfrequent menstruation\nmass on vulva\njaw pain\nitching of scrotum\npostpartum problems of the breast\neyelid retracted\nhesitancy\nelbow lump or mass\nmuscle weakness\nthroat redness\njoint swelling\ntongue pain\nredness in or around nose\nwrinkles on skin\nfoot or toe weakness\nhand or finger cramps or spasms\nback stiffness or tightness\nwrist lump or mass\nskin pain\nlow back stiffness or tightness\nlow urine output\nskin on head or neck looks infected\nstuttering or stammering\nproblems with orgasm\nnose deformity\nlump over jaw\nsore in nose\nhip weakness\nback swelling\nankle stiffness or tightness\nankle weakness\nneck weakness"
        },
        {
          "role": "user",
          "content":
              "I am feeling pain in my neck. I am panicking about it. My eyes are hurting. I am noticing redness in my pee."
        },
        {
          "role": "assistant",
          "content":
              "Neck Weakness\nAnxiety and Nervousness\neye burns or stings\nblood in urine\n"
        },
        {
          "role": "user",
          "content":
              "I noticed some white area in my mouth and it hurts. I also feel particular pain in my chest as if I am getting poked. It also feels like my stomach is on fire after I do some workout."
        },
        {
          "role": "assistant",
          "content": "mouth ulcer\nsharp chest pain\nburning abdominal pain"
        },
        {
          "role": "user",
          "content":
              "I am not feeling well today. I have some pain at my back and I see some red color on my skin."
        },
        {
          "role": "assistant",
          "content": "feeling ill\nback pain\nabnormal appearing skin"
        },
        {"role": "user", "content": transcript},
      ],
      "max_tokens": 800,
      "temperature": 0.7,
      "frequency_penalty": 0,
      "presence_penalty": 0,
      "top_p": 0.95,
      "stop": null
    });

    try {
      final http.Response httpResponse = await http.post(
        Uri.parse(model_url),
        headers: headers,
        body: body,
      );

      var response = {};

      if (httpResponse.statusCode == 200) {
        response = json.decode(httpResponse.body);
      } else {
        throw Exception('Failed to load data');
      }
      print("symptom listing LLM: ${response.toString()}");
      String listresult = response["choices"][0]["message"]["content"];
      return listresult.split('\n');
    } catch (error) {
      print(error);
      return [""];
    }
  }

  Future<Map<String, List<String>>> symptomLocate(List<String> symptoms) async {
    // OUTPUT MAP<SYMPTOM, LIST<Location>>

    var model_url =
        "https://quectollm.openai.azure.com/openai/deployments/quectoprofiling/chat/completions?api-version=2023-07-01-preview";
    var headers = {
      'Content-Type': 'application/json',
      'api-key': "31f4ac62df474e1793542a6671805904",
    };

    var body = jsonEncode({
      "messages": [
        {
          "role": "system",
          "content":
              "You are a clinical assistant who maps each symptom to the most relevant body parts only mentioned in the following list, one line for one symptom and strictly follow such format. It can only be in this list and not other output is accepted. head, nose, mouth, throat, forehead, eyes, face cheeks, ears, chin, neck, shoulders, biceps, forearms, hands, elbows, chest, abdomen, hip, groins, thighs, penis, vagina, knees, calfs, ankles, foot, glutes, upper back, lower back, wrist, anus, uterus, testicles, intestines"
        },
        {"role": "user", "content": "back pain, penis bleeding"},
        {
          "role": "assistant",
          "content": "back pain: upper back, lower back\npenis bleeding: penis"
        },
        {"role": "user", "content": symptoms.toString()},
      ],
      "max_tokens": 800,
      "temperature": 0.7,
      "frequency_penalty": 0,
      "presence_penalty": 0,
      "top_p": 0.95,
      "stop": null
    });
    try {
      final http.Response httpResponse = await http.post(
        Uri.parse(model_url),
        headers: headers,
        body: body,
      );

      var response = {};
      Map<String, String> result = {};

      if (httpResponse.statusCode == 200) {
        print("Raw Symptom Location Result: ${httpResponse.body}");
        response = json.decode(httpResponse.body);
      } else {
        throw Exception('Failed to load data');
      }

      List<String> listResultLines =
          response["choices"][0]["message"]["content"].split('\n');
      Map<String, String> symptom_disease = {};
      listResultLines.forEach((element) {
        List<String> key_val_pair = element.split(":");
        if (key_val_pair.length == 2) {
          symptom_disease[key_val_pair[0].trim()] = key_val_pair[1].trim();
        }
      });

      Map<String, List<String>> finalSymptomLocateResult = {};
      symptom_disease.forEach((key, value) {
        List<String> valueList =
            value.split(',').map((String item) => item.trim()).toList();
        finalSymptomLocateResult[key] = valueList;
      });

      print("Result Locations: ${finalSymptomLocateResult.toString()}");
      return finalSymptomLocateResult;
    } catch (error) {
      print(error);
      return {};
    }
  }
}
