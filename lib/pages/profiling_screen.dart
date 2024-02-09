import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp/components/profiling_visual.dart';
import 'package:mvp/model/Patient.dart';
import 'package:http/http.dart' as http;
import 'package:mvp/model/SymptomProfile.dart';

class ProfilingScreen extends StatefulWidget {
  final Map<String, String> symptomProfile;
  const ProfilingScreen({super.key, required this.symptomProfile});

  @override
  State<ProfilingScreen> createState() => _ProfilingScreenState();
}

class _ProfilingScreenState extends State<ProfilingScreen> {
  List<String> classes = ['abdominal aortic aneurysm' 'abdominal hernia' 'abscess of nose'
 'abscess of the lung' 'abscess of the pharynx' 'acanthosis nigricans'
 'acariasis' 'achalasia' 'acne' 'actinic keratosis' 'acute bronchiolitis'
 'acute bronchitis' 'acute bronchospasm'
 'acute fatty liver of pregnancy (aflp)' 'acute glaucoma'
 'acute kidney injury' 'acute otitis media' 'acute pancreatitis'
 'acute respiratory distress syndrome (ards)' 'acute sinusitis'
 'acute stress reaction' 'adhesive capsulitis of the shoulder'
 'adjustment reaction' 'adrenal adenoma' 'adrenal cancer' 'alcohol abuse'
 'alcohol intoxication' 'alcohol withdrawal' 'alcoholic liver disease'
 'allergy' 'allergy to animals' 'alopecia' 'alzheimer disease' 'amblyopia'
 'amyloidosis' 'amyotrophic lateral sclerosis (als)' 'anal fissure'
 'anal fistula' 'anemia' 'anemia due to chronic kidney disease'
 'anemia due to malignancy' 'anemia of chronic disease' 'angina'
 'ankylosing spondylitis' 'anxiety' 'aortic valve disease' 'aphakia'
 'aphthous ulcer' 'aplastic anemia' 'appendicitis' 'arrhythmia'
 'arthritis of the hip' 'ascending cholangitis' 'asperger syndrome'
 'aspergillosis' 'asthma' 'astigmatism' 'atelectasis' "athlete's foot"
 'atonic bladder' 'atrial fibrillation' 'atrial flutter'
 'atrophic skin condition' 'atrophic vaginitis'
 'atrophy of the corpus cavernosum'
 'attention deficit hyperactivity disorder (adhd)' 'autism'
 'autonomic nervous system disorder' 'avascular necrosis' 'balanitis'
 'bell palsy' 'benign kidney cyst'
 'benign paroxysmal positional vertical (bppv)'
 'benign prostatic hyperplasia (bph)'
 'benign vaginal discharge (leukorrhea)' 'bipolar disorder' 'birth trauma'
 'bladder cancer' 'bladder disorder' 'bladder obstruction' 'blepharitis'
 'blepharospasm' 'bone cancer' 'bone disorder'
 'bone spur of the calcaneous' 'brachial neuritis' 'brain cancer'
 'breast cancer' 'breast cyst' 'breast infection (mastitis)'
 'broken tooth' 'bunion' 'burn' 'bursitis' 'callus'
 'carbon monoxide poisoning' 'carcinoid syndrome' 'cardiac arrest'
 'cardiomyopathy' 'carpal tunnel syndrome' 'cat scratch disease'
 'cataract' 'celiac disease' 'cellulitis or abscess of mouth'
 'central atherosclerosis' 'central retinal artery or vein occlusion'
 'cerebral edema' 'cerebral palsy' 'cervical cancer' 'cervical disorder'
 'cervicitis' 'chalazion' 'chickenpox' 'chlamydia' 'cholecystitis'
 'choledocholithiasis' 'cholesteatoma' 'chondromalacia of the patella'
 'chorioretinitis' 'chronic back pain' 'chronic constipation'
 'chronic glaucoma'
 'chronic inflammatory demyelinating polyneuropathy (cidp)'
 'chronic kidney disease' 'chronic knee pain'
 'chronic obstructive pulmonary disease (copd)' 'chronic otitis media'
 'chronic pain disorder' 'chronic pancreatitis' 'chronic rheumatic fever'
 'chronic sinusitis' 'chronic ulcer' 'cirrhosis'
 'coagulation (bleeding) disorder' 'cold sore' 'colonic polyp'
 'colorectal cancer' 'common cold' 'complex regional pain syndrome'
 'concussion' 'conduct disorder' 'conductive hearing loss'
 'congenital heart defect' 'congenital malformation syndrome'
 'conjunctivitis' 'conjunctivitis due to allergy'
 'conjunctivitis due to bacteria' 'conjunctivitis due to virus'
 'connective tissue disorder' 'contact dermatitis' 'conversion disorder'
 'cornea infection' 'corneal abrasion' 'corneal disorder'
 'coronary atherosclerosis' 'cranial nerve palsy' 'crohn disease' 'croup'
 'crushing injury' 'cryptococcosis' 'cryptorchidism' 'cushing syndrome'
 'cyst of the eyelid' 'cystic fibrosis' 'cysticercosis' 'cystitis'
 'de quervain disease' 'decubitus ulcer' 'deep vein thrombosis (dvt)'
 'degenerative disc disease' 'delirium' 'dementia' 'dengue fever'
 'dental caries' 'depression' 'dermatitis due to sun exposure'
 'developmental disability' 'deviated nasal septum' 'diabetes'
 'diabetes insipidus' 'diabetic ketoacidosis' 'diabetic kidney disease'
 'diabetic peripheral neuropathy' 'diabetic retinopathy' 'diaper rash'
 'dislocation of the ankle' 'dislocation of the elbow'
 'dislocation of the finger' 'dislocation of the foot'
 'dislocation of the hip' 'dislocation of the knee'
 'dislocation of the patella' 'dislocation of the shoulder'
 'dislocation of the vertebra' 'dislocation of the wrist'
 'dissociative disorder' 'diverticulitis' 'diverticulosis' 'down syndrome'
 'drug abuse' 'drug abuse (barbiturates)' 'drug abuse (cocaine)'
 'drug abuse (methamphetamine)' 'drug abuse (opioids)'
 'drug poisoning due to medication' 'drug reaction' 'drug withdrawal'
 'dry eye of unknown cause' 'dumping syndrome' 'dyshidrosis'
 'dysthymic disorder' 'ear drum damage' 'ear wax impaction'
 'eating disorder' 'ectopic pregnancy' 'ectropion' 'eczema'
 'edward syndrome' 'emphysema' 'empyema' 'encephalitis' 'endocarditis'
 'endometrial cancer' 'endometrial hyperplasia' 'endometriosis'
 'endophthalmitis' 'envenomation from spider or animal bite' 'ependymoma'
 'epididymitis' 'epidural hemorrhage' 'epilepsy' 'erectile dysfunction'
 'erythema multiforme' 'esophageal cancer' 'esophageal varices'
 'esophagitis' 'essential tremor'
 'eustachian tube dysfunction (ear disorder)'
 'extrapyramidal effect of drugs' 'eye alignment disorder'
 'factitious disorder' 'female genitalia infection'
 'female infertility of unknown cause' 'fetal alcohol syndrome'
 'fibroadenoma' 'fibrocystic breast disease' 'fibromyalgia' 'flat feet'
 'floaters' 'flu' 'fluid overload' 'folate deficiency' 'food allergy'
 'foreign body in the ear' 'foreign body in the eye'
 'foreign body in the gastrointestinal tract' 'foreign body in the nose'
 'foreign body in the throat' 'foreign body in the vagina'
 'fracture of the ankle' 'fracture of the arm'
 'fracture of the facial bones' 'fracture of the finger'
 'fracture of the foot' 'fracture of the hand' 'fracture of the jaw'
 'fracture of the leg' 'fracture of the neck' 'fracture of the patella'
 'fracture of the pelvis' 'fracture of the rib' 'fracture of the shoulder'
 'fracture of the skull' 'fracture of the vertebra' 'friedrich ataxia'
 'frostbite' 'fungal infection of the hair' 'fungal infection of the skin'
 'g6pd enzyme deficiency' 'galactorrhea of unknown cause' 'gallstone'
 'ganglion cyst' 'gas gangrene' 'gastritis' 'gastroduodenal ulcer'
 'gastroesophageal reflux disease (gerd)' 'gastrointestinal hemorrhage'
 'gastroparesis' 'genital herpes' 'gestational diabetes' 'glaucoma'
 'glucocorticoid deficiency' 'goiter' 'gonorrhea' 'gout'
 'granuloma inguinale' 'graves disease' 'guillain barre syndrome'
 'gum disease' 'gynecomastia' 'hammer toe' 'hashimoto thyroiditis'
 'head and neck cancer' 'head injury' 'headache after lumbar puncture'
 'heart attack' 'heart block' 'heart contusion' 'heart failure'
 'heat exhaustion' 'heat stroke' 'hemangioma' 'hemarthrosis' 'hematoma'
 'hemiplegia' 'hemochromatosis' 'hemolytic anemia' 'hemophilia'
 'hemorrhoids' 'hepatic encephalopathy' 'hepatitis due to a toxin'
 'herniated disk' 'herpangina' 'hiatal hernia' 'hidradenitis suppurativa'
 'high blood pressure' 'hirschsprung disease' 'hirsutism' 'histoplasmosis'
 'hormone disorder' 'hpv' 'human immunodeficiency virus infection (hiv)'
 'huntington disease' 'hydatidiform mole' 'hydrocele of the testicle'
 'hydrocephalus' 'hydronephrosis' 'hypercalcemia' 'hypercholesterolemia'
 'hyperemesis gravidarum' 'hypergammaglobulinemia' 'hyperhidrosis'
 'hyperkalemia' 'hyperlipidemia' 'hypernatremia' 'hyperopia'
 'hyperosmotic hyperketotic state' 'hypertension of pregnancy'
 'hypertensive heart disease'
 'hypertrophic obstructive cardiomyopathy (hocm)' 'hypocalcemia'
 'hypoglycemia' 'hypokalemia' 'hyponatremia' 'hypothermia'
 'hypothyroidism' 'hypovolemia' 'idiopathic absence of menstruation'
 'idiopathic excessive menstruation' 'idiopathic infrequent menstruation'
 'idiopathic irregular menstrual cycle' 'idiopathic nonmenstrual bleeding'
 'idiopathic painful menstruation' 'ileus' 'impetigo'
 'impulse control disorder' 'indigestion' 'induced abortion'
 'infection of open wound' 'infectious gastroenteritis' 'ingrown toe nail'
 'inguinal hernia' 'injury of the ankle' 'injury to internal organ'
 'injury to the abdomen' 'injury to the arm' 'injury to the face'
 'injury to the finger' 'injury to the hand' 'injury to the hip'
 'injury to the knee' 'injury to the leg' 'injury to the shoulder'
 'injury to the spinal cord' 'injury to the trunk' 'insect bite'
 'insulin overdose' 'interstitial lung disease'
 'intertrigo (skin condition)' 'intestinal cancer' 'intestinal disease'
 'intestinal malabsorption' 'intestinal obstruction'
 'intracerebral hemorrhage' 'intracranial abscess'
 'intracranial hemorrhage' 'intussusception' 'iridocyclitis'
 'iron deficiency anemia' 'irritable bowel syndrome'
 'ischemia of the bowel' 'ischemic heart disease'
 'itching of unknown cause' 'jaw disorder' 'joint effusion'
 'juvenile rheumatoid arthritis' 'kaposi sarcoma' 'kidney cancer'
 'kidney disease due to longstanding hypertension' 'kidney failure'
 'kidney stone' 'knee ligament or meniscus tear' 'labyrinthitis'
 'lactose intolerance' 'laryngitis' 'lateral epicondylitis (tennis elbow)'
 'leukemia' 'lewy body dementia' 'lice' 'lichen planus' 'lichen simplex'
 'lipoma' 'liver cancer' 'liver disease' 'lumbago' 'lung cancer'
 'lung contusion' 'lyme disease' 'lymphadenitis' 'lymphangitis'
 'lymphedema' 'lymphogranuloma venereum' 'lymphoma' 'macular degeneration'
 'magnesium deficiency' 'malaria' 'male genitalia infection'
 'malignant hypertension' 'marijuana abuse' 'mastectomy' 'mastoiditis'
 'meckel diverticulum' 'melanoma' 'meniere disease' 'meningioma'
 'meningitis' 'menopause' 'metabolic disorder' 'metastatic cancer'
 'migraine' 'missed abortion' 'mitral valve disease' 'mittelschmerz'
 'molluscum contagiosum' 'mononeuritis' 'mononucleosis' 'moyamoya disease'
 'mucositis' 'multiple myeloma' 'multiple sclerosis' 'mumps'
 'muscle spasm' 'muscular dystrophy' 'myasthenia gravis'
 'myelodysplastic syndrome' 'myocarditis' 'myoclonus' 'myopia' 'myositis'
 'narcolepsy' 'nasal polyp' 'necrotizing fasciitis' 'neonatal jaundice'
 'nerve impingement near the shoulder' 'neuralgia' 'neurofibromatosis'
 'neuropathy due to drugs' 'neurosis' 'nonalcoholic liver disease (nash)'
 'noninfectious gastroenteritis' 'normal pressure hydrocephalus'
 'nose disorder' 'obesity' 'obsessive compulsive disorder (ocd)'
 'obstructive sleep apnea (osa)' 'omphalitis' 'onychomycosis'
 'open wound due to trauma' 'open wound from surgical incision'
 'open wound of the abdomen' 'open wound of the arm'
 'open wound of the back' 'open wound of the cheek'
 'open wound of the chest' 'open wound of the ear' 'open wound of the eye'
 'open wound of the face' 'open wound of the finger'
 'open wound of the foot' 'open wound of the hand'
 'open wound of the head' 'open wound of the jaw' 'open wound of the knee'
 'open wound of the lip' 'open wound of the mouth'
 'open wound of the neck' 'open wound of the nose'
 'open wound of the shoulder' 'oppositional disorder' 'optic neuritis'
 'oral leukoplakia' 'oral mucosal lesion' 'oral thrush (yeast infection)'
 'orbital cellulitis' 'orthostatic hypotension' 'osteoarthritis'
 'osteochondroma' 'osteochondrosis' 'osteomyelitis' 'osteoporosis'
 "otitis externa (swimmer's ear)" 'otitis media' 'otosclerosis'
 'ovarian cancer' 'ovarian cyst' 'ovarian torsion' 'overflow incontinence'
 'pain after an operation' 'pain disorder affecting the neck'
 'pancreatic cancer' 'panic attack' 'panic disorder' 'parasitic disease'
 'parathyroid adenoma' 'parkinson disease' 'paronychia'
 'paroxysmal supraventricular tachycardia'
 'paroxysmal ventricular tachycardia' 'pelvic fistula'
 'pelvic inflammatory disease' 'pelvic organ prolapse' 'pemphigus'
 'pericarditis' 'peripheral arterial disease'
 'peripheral arterial embolism' 'peripheral nerve disorder'
 'perirectal infection' 'peritonitis' 'peritonsillar abscess'
 'persistent vomiting of unknown cause' 'personality disorder'
 'peyronie disease' 'pharyngitis' 'phimosis' 'pilonidal cyst' 'pinguecula'
 'pinworm infection' 'pituitary adenoma' 'pituitary disorder'
 'pityriasis rosea' 'placenta previa' 'placental abruption'
 'plantar fasciitis' 'pleural effusion' 'pneumoconiosis' 'pneumonia'
 'pneumothorax' 'poisoning due to analgesics'
 'poisoning due to anticonvulsants' 'poisoning due to antidepressants'
 'poisoning due to antihypertensives'
 'poisoning due to antimicrobial drugs' 'poisoning due to antipsychotics'
 'poisoning due to ethylene glycol' 'poisoning due to gas'
 'poisoning due to opioids' 'poisoning due to sedatives'
 'polycystic kidney disease' 'polycystic ovarian syndrome (pcos)'
 'polycythemia vera' 'polymyalgia rheumatica'
 'post-traumatic stress disorder (ptsd)' 'postoperative infection'
 'postpartum depression' 'preeclampsia' 'pregnancy'
 'premature atrial contractions (pacs)' 'premature ovarian failure'
 'premature rupture of amniotic membrane'
 'premature ventricular contractions (pvcs)'
 'premenstrual tension syndrome' 'presbyacusis' 'presbyopia' 'priapism'
 'primary immunodeficiency' 'primary insomnia' 'primary kidney disease'
 'primary thrombocythemia' 'problem during pregnancy' 'prostate cancer'
 'prostatitis' 'protein deficiency' 'pseudohypoparathyroidism'
 'pseudotumor cerebri' 'psoriasis' 'psychosexual disorder'
 'psychotic disorder' 'pterygium' 'pulmonary congestion'
 'pulmonary embolism' 'pulmonary eosinophilia' 'pulmonary fibrosis'
 'pulmonary hypertension' 'pulmonic valve disease' 'pyelonephritis'
 'pyloric stenosis' 'pyogenic skin infection' 'raynaud disease'
 'reactive arthritis' 'rectal disorder' 'restless leg syndrome'
 'retinal detachment' 'retinopathy due to high blood pressure'
 'rhabdomyolysis' 'rheumatic fever' 'rheumatoid arthritis'
 'rocky mountain spotted fever' 'rosacea' 'rotator cuff injury'
 'salivary gland disorder' 'sarcoidosis' 'scabies' 'scar' 'scarlet fever'
 'schizophrenia' 'sciatica' 'scleritis' 'scleroderma' 'scoliosis' 'scurvy'
 'seasonal allergies (hay fever)' 'sebaceous cyst' 'seborrheic dermatitis'
 'seborrheic keratosis' 'sensorineural hearing loss' 'sepsis'
 'septic arthritis' 'shingles (herpes zoster)' 'sialoadenitis'
 'sick sinus syndrome' 'sickle cell anemia' 'sickle cell crisis'
 'sinus bradycardia' 'sjogren syndrome' 'skin cancer' 'skin disorder'
 'skin pigmentation disorder' 'skin polyp' 'smoking or tobacco addiction'
 'social phobia' 'soft tissue sarcoma' 'somatization disorder'
 'spermatocele' 'spherocytosis' 'spina bifida' 'spinal stenosis'
 'spinocerebellar ataxia' 'spondylitis' 'spondylolisthesis' 'spondylosis'
 'spontaneous abortion' 'sporotrichosis' 'sprain or strain'
 'stenosis of the tear duct' 'stomach cancer' 'strep throat'
 'stress incontinence' 'stricture of the esophagus' 'stroke' 'stye'
 'subacute thyroiditis' 'subarachnoid hemorrhage'
 'subconjunctival hemorrhage' 'subdural hemorrhage'
 'substance-related mental disorder'
 'syndrome of inappropriate secretion of adh (siadh)' 'syphilis'
 'syringomyelia' 'systemic lupus erythematosis (sle)' 'teething syndrome'
 'temporary or benign blood in urine' 'temporomandibular joint disorder'
 'tendinitis' 'tension headache' 'testicular cancer' 'testicular disorder'
 'testicular torsion' 'thalassemia' 'thoracic aortic aneurysm'
 'thoracic outlet syndrome' 'threatened pregnancy' 'thrombocytopenia'
 'thrombophlebitis' 'thyroid cancer' 'thyroid disease' 'thyroid nodule'
 'tic (movement) disorder' 'tietze syndrome' 'tinnitus of unknown cause'
 'tonsillar hypertrophy' 'tonsillitis' 'tooth abscess' 'tooth disorder'
 'torticollis' 'tourette syndrome' 'toxic multinodular goiter'
 'toxoplasmosis' 'tracheitis' 'transient ischemic attack' 'trichiasis'
 'trichinosis' 'trichomonas infection' 'tricuspid valve disease'
 'trigeminal neuralgia' 'trigger finger (finger disorder)' 'tuberculosis'
 'tuberous sclerosis' 'turner syndrome' 'typhoid fever'
 'ulcerative colitis' 'urethral disorder' 'urethral stricture'
 'urethral valves' 'urethritis' 'urge incontinence'
 'urinary tract infection' 'urinary tract obstruction' 'uterine atony'
 'uterine cancer' 'uterine fibroids' 'uveitis' 'vacterl syndrome'
 'vaginal cyst' 'vaginal yeast infection' 'vaginismus' 'vaginitis'
 'valley fever' 'varicocele of the testicles' 'varicose veins'
 'vasculitis' 'venous insufficiency' 'vertebrobasilar insufficiency'
 'vesicoureteral reflux' 'viral exanthem' 'viral hepatitis' 'viral warts'
 'vitamin a deficiency' 'vitamin b12 deficiency' 'vitamin d deficiency'
 'vitreous degeneration' 'vitreous hemorrhage' 'vocal cord polyp'
 'volvulus' 'von willebrand disease' 'vulvar cancer' 'vulvar disorder'
 'vulvodynia' 'wernicke korsakoff syndrome' 'white blood cell disease'
 'whooping cough' 'wilson disease' 'yeast infection' 'zenker diverticulum'];
  Map<String, int> map = {};
  // String highRiskDisease = "";
  
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 1), () async {
    //   highRiskDisease = await getHighRiskDisease(widget.symptomProfile);
    // });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.symptomProfile.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: ProfileVisual(
              patient: Patient(
                name: "Noki",
                age: 20,
                gender: widget.symptomProfile.containsValue("vagina") ? "female" : "male",
              ),
              // highRiskDisease: getHighRiskDisease(symptomProfile),
              symptom2location: widget.symptomProfile,
            ),
          ),
          Positioned(
            bottom: 80,
            left: 130,
            child: InkWell(
              child: ElevatedButton(
                onPressed: () {
                  context.go("/scribe");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Button border radius
                  ),
                  elevation: 2.5, // Elevation of the button
                  fixedSize: const Size(125, 45),
                ),
                child: const Text(
                  'Studio',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        blurRadius: 1.0,
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getHighRiskDisease(Map<String, String> symptomProfile) async {
    map = classes.asMap().map((index, value) => MapEntry(value, 0));
    for (var entry in symptomProfile.entries) {
      map[entry.key] = 1;
    }
    var inputMatrix = [];
    for (var data in map.entries) {
      inputMatrix.add(data.value);
    }
    var url = "https://quecto-i2d-endpoint.eastus.inference.ml.azure.com/score";
    
    var apiKey = "2MtgebdlSefbaIpIlIUJsr7qp92gNKLb";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${apiKey}",
      "azureml-model-deployment": "i2d-soft-classifier-3"
    };
    var body = {
      {
        "input_data": {
    "columns": [
      "anxiety and nervousness",
      "depression",
      "shortness of breath",
      "depressive or psychotic symptoms",
      "sharp chest pain",
      "dizziness",
      "insomnia",
      "abnormal involuntary movements",
      "chest tightness",
      "palpitations",
      "irregular heartbeat",
      "breathing fast",
      "hoarse voice",
      "sore throat",
      "difficulty speaking",
      "cough",
      "nasal congestion",
      "throat swelling",
      "diminished hearing",
      "lump in throat",
      "throat feels tight",
      "difficulty in swallowing",
      "skin swelling",
      "retention of urine",
      "groin mass",
      "leg pain",
      "hip pain",
      "suprapubic pain",
      "blood in stool",
      "lack of growth",
      "emotional symptoms",
      "elbow weakness",
      "back weakness",
      "pus in sputum",
      "symptoms of the scrotum and testes",
      "swelling of scrotum",
      "pain in testicles",
      "flatulence",
      "pus draining from ear",
      "jaundice",
      "mass in scrotum",
      "white discharge from eye",
      "irritable infant",
      "abusing alcohol",
      "fainting",
      "hostile behavior",
      "drug abuse",
      "sharp abdominal pain",
      "feeling ill",
      "vomiting",
      "headache",
      "nausea",
      "diarrhea",
      "vaginal itching",
      "vaginal dryness",
      "painful urination",
      "involuntary urination",
      "pain during intercourse",
      "frequent urination",
      "lower abdominal pain",
      "vaginal discharge",
      "blood in urine",
      "hot flashes",
      "intermenstrual bleeding",
      "hand or finger pain",
      "wrist pain",
      "hand or finger swelling",
      "arm pain",
      "wrist swelling",
      "arm stiffness or tightness",
      "arm swelling",
      "hand or finger stiffness or tightness",
      "wrist stiffness or tightness",
      "lip swelling",
      "toothache",
      "abnormal appearing skin",
      "skin lesion",
      "acne or pimples",
      "dry lips",
      "facial pain",
      "mouth ulcer",
      "skin growth",
      "eye deviation",
      "diminished vision",
      "double vision",
      "cross-eyed",
      "symptoms of eye",
      "pain in eye",
      "eye moves abnormally",
      "abnormal movement of eyelid",
      "foreign body sensation in eye",
      "irregular appearing scalp",
      "swollen lymph nodes",
      "back pain",
      "neck pain",
      "low back pain",
      "pain of the anus",
      "pain during pregnancy",
      "pelvic pain",
      "impotence",
      "infant spitting up",
      "vomiting blood",
      "regurgitation",
      "burning abdominal pain",
      "restlessness",
      "symptoms of infants",
      "wheezing",
      "peripheral edema",
      "neck mass",
      "ear pain",
      "jaw swelling",
      "mouth dryness",
      "neck swelling",
      "knee pain",
      "foot or toe pain",
      "bowlegged or knock-kneed",
      "ankle pain",
      "bones are painful",
      "knee weakness",
      "elbow pain",
      "knee swelling",
      "skin moles",
      "knee lump or mass",
      "weight gain",
      "problems with movement",
      "knee stiffness or tightness",
      "leg swelling",
      "foot or toe swelling",
      "heartburn",
      "smoking problems",
      "muscle pain",
      "infant feeding problem",
      "recent weight loss",
      "problems with shape or size of breast",
      "underweight",
      "difficulty eating",
      "scanty menstrual flow",
      "vaginal pain",
      "vaginal redness",
      "vulvar irritation",
      "weakness",
      "decreased heart rate",
      "increased heart rate",
      "bleeding or discharge from nipple",
      "ringing in ear",
      "plugged feeling in ear",
      "itchy ear(s)",
      "frontal headache",
      "fluid in ear",
      "neck stiffness or tightness",
      "spots or clouds in vision",
      "eye redness",
      "lacrimation",
      "itchiness of eye",
      "blindness",
      "eye burns or stings",
      "itchy eyelid",
      "feeling cold",
      "decreased appetite",
      "excessive appetite",
      "excessive anger",
      "loss of sensation",
      "focal weakness",
      "slurring words",
      "symptoms of the face",
      "disturbance of memory",
      "paresthesia",
      "side pain",
      "fever",
      "shoulder pain",
      "shoulder stiffness or tightness",
      "shoulder weakness",
      "arm cramps or spasms",
      "shoulder swelling",
      "tongue lesions",
      "leg cramps or spasms",
      "abnormal appearing tongue",
      "ache all over",
      "lower body pain",
      "problems during pregnancy",
      "spotting or bleeding during pregnancy",
      "cramps and spasms",
      "upper abdominal pain",
      "stomach bloating",
      "changes in stool appearance",
      "unusual color or odor to urine",
      "kidney mass",
      "swollen abdomen",
      "symptoms of prostate",
      "leg stiffness or tightness",
      "difficulty breathing",
      "rib pain",
      "joint pain",
      "muscle stiffness or tightness",
      "pallor",
      "hand or finger lump or mass",
      "chills",
      "groin pain",
      "fatigue",
      "abdominal distention",
      "regurgitation.1",
      "symptoms of the kidneys",
      "melena",
      "flushing",
      "coughing up sputum",
      "seizures",
      "delusions or hallucinations",
      "shoulder cramps or spasms",
      "joint stiffness or tightness",
      "pain or soreness of breast",
      "excessive urination at night",
      "bleeding from eye",
      "rectal bleeding",
      "constipation",
      "temper problems",
      "coryza",
      "wrist weakness",
      "eye strain",
      "hemoptysis",
      "lymphedema",
      "skin on leg or foot looks infected",
      "allergic reaction",
      "congestion in chest",
      "muscle swelling",
      "pus in urine",
      "abnormal size or shape of ear",
      "low back weakness",
      "sleepiness",
      "apnea",
      "abnormal breathing sounds",
      "excessive growth",
      "elbow cramps or spasms",
      "feeling hot and cold",
      "blood clots during menstrual periods",
      "absence of menstruation",
      "pulling at ears",
      "gum pain",
      "redness in ear",
      "fluid retention",
      "flu-like syndrome",
      "sinus congestion",
      "painful sinuses",
      "fears and phobias",
      "recent pregnancy",
      "uterine contractions",
      "burning chest pain",
      "back cramps or spasms",
      "stiffness all over",
      "muscle cramps, contractures, or spasms",
      "low back cramps or spasms",
      "back mass or lump",
      "nosebleed",
      "long menstrual periods",
      "heavy menstrual flow",
      "unpredictable menstruation",
      "painful menstruation",
      "infertility",
      "frequent menstruation",
      "sweating",
      "mass on eyelid",
      "swollen eye",
      "eyelid swelling",
      "eyelid lesion or rash",
      "unwanted hair",
      "symptoms of bladder",
      "irregular appearing nails",
      "itching of skin",
      "hurts to breath",
      "nailbiting",
      "skin dryness, peeling, scaliness, or roughness",
      "skin on arm or hand looks infected",
      "skin irritation",
      "itchy scalp",
      "hip swelling",
      "incontinence of stool",
      "foot or toe cramps or spasms",
      "warts",
      "bumps on penis",
      "too little hair",
      "foot or toe lump or mass",
      "skin rash",
      "mass or swelling around the anus",
      "low back swelling",
      "ankle swelling",
      "hip lump or mass",
      "drainage in throat",
      "dry or flaky scalp",
      "premenstrual tension or irritability",
      "feeling hot",
      "feet turned in",
      "foot or toe stiffness or tightness",
      "pelvic pressure",
      "elbow swelling",
      "elbow stiffness or tightness",
      "early or late onset of menopause",
      "mass on ear",
      "bleeding from ear",
      "hand or finger weakness",
      "low self-esteem",
      "throat irritation",
      "itching of the anus",
      "swollen or red tonsils",
      "irregular belly button",
      "swollen tongue",
      "lip sore",
      "vulvar sore",
      "hip stiffness or tightness",
      "mouth pain",
      "arm weakness",
      "leg lump or mass",
      "disturbance of smell or taste",
      "discharge in stools",
      "penis pain",
      "loss of sex drive",
      "obsessions and compulsions",
      "antisocial behavior",
      "neck cramps or spasms",
      "pupils unequal",
      "poor circulation",
      "thirst",
      "sleepwalking",
      "skin oiliness",
      "sneezing",
      "bladder mass",
      "knee cramps or spasms",
      "premature ejaculation",
      "leg weakness",
      "posture problems",
      "bleeding in mouth",
      "tongue bleeding",
      "change in skin mole size or color",
      "penis redness",
      "penile discharge",
      "shoulder lump or mass",
      "polyuria",
      "cloudy eye",
      "hysterical behavior",
      "arm lump or mass",
      "nightmares",
      "bleeding gums",
      "pain in gums",
      "bedwetting",
      "diaper rash",
      "lump or mass of breast",
      "vaginal bleeding after menopause",
      "infrequent menstruation",
      "mass on vulva",
      "jaw pain",
      "itching of scrotum",
      "postpartum problems of the breast",
      "eyelid retracted",
      "hesitancy",
      "elbow lump or mass",
      "muscle weakness",
      "throat redness",
      "joint swelling",
      "tongue pain",
      "redness in or around nose",
      "wrinkles on skin",
      "foot or toe weakness",
      "hand or finger cramps or spasms",
      "back stiffness or tightness",
      "wrist lump or mass",
      "skin pain",
      "low back stiffness or tightness",
      "low urine output",
      "skin on head or neck looks infected",
      "stuttering or stammering",
      "problems with orgasm",
      "nose deformity",
      "lump over jaw",
      "sore in nose",
      "hip weakness",
      "back swelling",
      "ankle stiffness or tightness",
      "ankle weakness",
      "neck weakness"
    ],
    "index": [1],
    "data": [inputMatrix]
  }
      }};
    var encodedBody = jsonEncode(body);
    try {
      var response = await http.post(Uri.parse(url), headers: headers, body: encodedBody);
      
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Request failed with status code ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      return jsonDecode(response.body)[0];
    } catch (e) {
      print('Error: $e');
    }
    return " ";

    
  }


  
}
