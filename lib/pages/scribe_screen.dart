import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:mvp/model/Scribe.dart';
import 'package:path/path.dart' as pathPkg;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp/components/analyze_button.dart';
import 'package:mvp/components/record_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:uuid/uuid.dart';

class ScribeScreen extends StatefulWidget {
  const ScribeScreen({super.key});

  @override
  State<ScribeScreen> createState() => _ScribeScreenState();
}

class _ScribeScreenState extends State<ScribeScreen> {
  late bool _isRecording;
  late FlutterSoundRecorder recorder;

  late String tempPath;
  late Scribe scribe;

  @override
  void initState() {
    super.initState();
    _isRecording = false;
    recorder = FlutterSoundRecorder();
    Permission.microphone.request();
    scribe = Scribe.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _isRecording
                      ? Positioned(
                          top: 30,
                          left: 30,
                          child: RippleAnimation(
                            child: SizedBox.shrink(),
                            repeat: true,
                          ),
                        )
                      : SizedBox.shrink(),
                  RecordButton(
                    onPressed: () async {
                      var permissionHandler = await Permission.microphone
                          //     .onDeniedCallback(
                          //   () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           title: Text("Mic access not granted."),
                          //           actions: [
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //               child: Text("OK"),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   },
                          // )
                          .request();
                      tempPath = await getPath();
                      if (permissionHandler.isGranted) {
                        setState(
                          () {
                            if (!_isRecording) {
                              print("Currently recording");
                              _isRecording = true;
                              RecordMp3.instance.start(tempPath, (p0) {
                                print(p0.toString());
                              });

                              // final audioSession = await AudioSession.instance;
                              // await audioSession.configuration(
                              //   AudioSessionConfiguration(
                              //     avAudioSessionCategory:
                              //         AVAudioSessionCategory.playAndRecord,
                              //     avAudioSessionCategoryOptions:
                              //         AVAudioSessionCategoryOptions
                              //                 .allowBluetooth |
                              //             AVAudioSessionCategoryOptions
                              //                 .defaultToSpeaker,
                              //     avAudioSessionMode:
                              //         AVAudioSessionMode.spokenAudio,
                              //     avAudioSessionRouteSharingPolicy:
                              //         AVAudioSessionRouteSharingPolicy
                              //             .defaultPolicy,
                              //     avAudioSessionSetActiveOptions:
                              //         AVAudioSessionSetActiveOptions.none,
                              //   ),
                              // );
                              // recorder
                              //     .startRecorder(
                              //   toFile: tempPath,
                              //   codec: Codec.pcm16WAV,
                              // )
                              //     .onError(
                              //   (error, stackTrace) {
                              //     print(error);
                              //     print(stackTrace);
                              //   },
                              // );
                            } else {
                              checkFileExists();
                              scribe =
                                  Scribe.autoConstruct(tempPath, false, "", "");
                              print("Recording stopped");
                              _isRecording = false;
                              // recorder.pauseRecorder();
                              RecordMp3.instance.pause();
                            }
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Mic access not granted.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          AnalyzeButton(
            onPress: () {
              // recorder.stopRecorder();
              // recorder.dispositionStream();
              RecordMp3.instance.stop();

              scribe.uploadedAudioToAZBlob(scribe.filepath, scribe.ID);
              context.go('/loading/${scribe.ID}');
            },
          ),
          // AnimatedButton(
          //   width: 100,
          //   backgroundColor: Colors.black,
          //   text: "Analyze",
          //   selectedTextColor: Colors.black,
          //   onPress: () {
          //     context.go('/loading');
          //   },
          // ),
        ],
      ),
    );
  }

  Future<String> getPath() async {
    var tempDir = await getApplicationCacheDirectory();
    String path = '${tempDir.path}/temp_scribe_audio.mp3';
    return path;
  }

  void checkFileExists() {
    // FlutterSoundPlayer soundPlayer = FlutterSoundPlayer();
    // soundPlayer.openPlayer();
    // soundPlayer
    //     .startPlayer(
    //   fromURI: tempPath,
    //   codec: Codec.pcm16WAV,
    //   whenFinished: () {
    //     soundPlayer.stopPlayer();
    //   },
    // )
    //     .onError(
    //   (error, stackTrace) {
    //     print(error);
    //     print("");
    //     print(stackTrace);
    //     print("File exist? --> " + File(tempPath).existsSync().toString());
    //   },
    // );

    print("File exist? --> " + File(tempPath).existsSync().toString());
  }
}
