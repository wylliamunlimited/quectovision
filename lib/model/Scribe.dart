import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:azblob/azblob.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as pathPKG;
import 'package:http/http.dart' as http;

class Scribe {
  late String filepath;
  late bool uploadedToAZBlob;
  late String ID;
  late String transcription;

  Scribe(
      {required this.filepath,
      this.uploadedToAZBlob = false,
      required this.ID,
      required this.transcription});

  Scribe.autoConstruct(
      this.filepath, this.uploadedToAZBlob, this.ID, this.transcription) {
    this.filepath = filepath;
    this.uploadedToAZBlob = false;
    this.ID = generateScribeID();
    this.transcription = "";
  }

  Scribe.empty() {
    this.filepath = "";
    this.uploadedToAZBlob = false;
    this.ID = "";
    this.transcription = "";
  }

  String generateScribeID() {
    DateTime currentTime = DateTime.now();
    String timePartition = currentTime.timeZoneName.toString() +
        currentTime.year.toString() +
        currentTime.month.toString() +
        currentTime.day.toString() +
        currentTime.hour.toString() +
        currentTime.minute.toString() +
        currentTime.second.toString() +
        currentTime.millisecond.toString();

    var uuid = Uuid().v1().toString();
    print("ID: " + timePartition + uuid);

    return timePartition + uuid;
  }

  // static Future<void> createTranscription(String ID) async {
  //   String url =
  //       'https://eastus.api.cognitive.microsoft.com/speechtotext/v3.1/transcriptions';
  //   final headers = {
  //     'Ocp-Apim-Subscription-Key': 'd0fb21013c3e4caf845c60cffeabc30f',
  //     'Content-Type': 'application/json',
  //   };

  //   final body = jsonEncode({
  //     'displayName': '20240203_144502',
  //     'description': 'Speech Studio Batch speech to text',
  //     'locale': 'en-us',
  //     'contentUrls': [
  //       'https://quectoclientrepo.blob.core.windows.net/scribe-audio/${ID}.mp3',
  //     ],
  //     'model': {
  //       'self':
  //           'https://eastus.api.cognitive.microsoft.com/speechtotext/v3.2-preview.1/models/base/32a18586-1b16-49dd-8f51-e25550331a2f',
  //     },
  //     'properties': {
  //       'wordLevelTimestampsEnabled': false,
  //       'displayFormWordLevelTimestampsEnabled': true,
  //       'diarizationEnabled': false,
  //       'punctuationMode': 'DictatedAndAutomatic',
  //       'profanityFilterMode': 'Masked',
  //     },
  //     'customProperties': {},
  //   });

  //   final response =
  //       await http.post(Uri.parse(url), headers: headers, body: body);

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     print('Request successful!'); // Handle the response as needed
  //   } else {
  //     print('Error: ${response.statusCode} - ${response.reasonPhrase}');
  //   }
  // }

  Future<bool> uploadedAudioToAZBlob(String filepath, String ID) async {
    String extension = pathPKG.extension(filepath);
    if (!File(filepath).existsSync()) {
      print("Scribe: File does not exist - - - Process terminated.");
      return false;
    } else {
      final storageAccountName = "quectoclientrepo";
      final containerName = "scribe-audio";
      final sasToken =
          "?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwlacpx&se=2034-02-09T16:56:27Z&st=2024-02-09T08:56:27Z&spr=https&sig=pyaohiKxFOXOvtdInFpyX3oojEnrkcz7crrRnh5x5W8%3D";

      try {
        var content = await File(filepath).readAsBytes();
        var storage = AzureStorage.parse(
            "DefaultEndpointsProtocol=https;AccountName=quectoclientrepo;AccountKey=4XUNNZKNFxhCDsrz+q+sxa6sCov1gGRMf9PVN2i3dzf8lZ8VEtrE+GJBl98IwW14gsGH07O0RAZN+ASt6i1Mdg==;EndpointSuffix=core.windows.net");

        // get the mine type of the file
        var contentType = lookupMimeType(filepath);
        await storage.putBlob('/${containerName}/${ID}.mp3',
            bodyBytes: content,
            contentType: contentType,
            type: BlobType.blockBlob);
        print("done");
        return true;
      } on AzureStorageException catch (e) {
        print(e.message);
        return false;
      }

      // final url = Uri.parse(
      //     'https://$storageAccountName.blob.core.windows.net/$containerName/${ID + "-" + filepath + extension}?$sasToken');

      // final url = Uri.parse(
      //     'https://$storageAccountName.blob.core.windows.net/$containerName/${ID + "-" + filepath + extension}');

      // final request = http.Request("PUT", url);

      // DateTime currentTime = DateTime.now();
      // String formattedDate =
      //     DateFormat('EEE, dd MMM yyyy HH:mm:ss z').format(currentTime);
      // print(File(filepath).lengthSync());
      // request.bodyBytes = await File(filepath).readAsBytes();
      // request.headers['x-ms-version'] =
      //     '${DateFormat('yyyy-MM-dd').format(currentTime)}';
      // request.headers['x-ms-date'] = '${formattedDate}';
      // request.headers['Content-Length'] =
      //     File(filepath).lengthSync().toString();
      // request.headers['Authorization'] =
      //     "SharedKey quectoclientrepo:4XUNNZKNFxhCDsrz+q+sxa6sCov1gGRMf9PVN2i3dzf8lZ8VEtrE+GJBl98IwW14gsGH07O0RAZN+ASt6i1Mdg==";

      // print(request.headers);

      // final response = await request.send();
      // if (response.statusCode == 201) {
      //   print("Scribe: Audio Upload Successful");
      //   return true;
      // } else {
      //   print("Scribe: Audio Upload Failed. Error: ${response.reasonPhrase}");
      //   return false;
      // }
    }
  }
}
