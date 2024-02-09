// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:noise_meter/noise_meter.dart';
// import 'package:siri_wave/siri_wave.dart';

// class RecordButton extends StatefulWidget {
//   const RecordButton({super.key, isRecording = false});
//   final bool isRecording = false;
//   @override
//   State<RecordButton> createState() => _RecordButtonState();
// }
//
// class _RecordButtonState extends State<RecordButton> {
//   late IOS9SiriWaveformController _waveController;
//   late IOS9SiriWaveformController _pauseController;
//   late bool _isRecording;
//   late NoiseMeter _noiseMeter;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _waveController = IOS9SiriWaveformController();
//     _pauseController = IOS9SiriWaveformController(
//       amplitude: 0.1,
//       speed: 0.01,
//     );
//     _isRecording = widget.isRecording;
//     _noiseMeter = NoiseMeter();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SiriWaveform.ios9(
//       controller: _isRecording ? _waveController : _pauseController,
//       options: IOS9SiriWaveformOptions(
//         height: 500,
//         width: 400,
//       ),
//     );
//   }
//
//   double calculateRMS(List<double> audioSamples) {
//     double sumSquared = 0;
//     for (double sample in audioSamples) {
//       sumSquared += sample * sample;
//     }
//     double meanSquared = sumSquared / audioSamples.length;
//     return sqrt(meanSquared);
//   }
//
//   void startRecording() {
//     _isRecording = true;
//     _noiseMeter.noise.listen((NoiseReading noiseReading) {
//       double decibels = noiseReading.meanDecibel;
//       // Calculate intensity (e.g., RMS) from decibels
//       double intensity = calculateRMS([decibels]);
//       // Update the SiriWaveWidget intensity
//       setState(() {
//         _waveController.amplitude = intensity;
//       });
//     });
//   }
//
//   void stopRecording() {
//     _isRecording = false;
//     setState(() {});
//   }
// }

class RecordButton extends StatelessWidget {
  const RecordButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30), // Adjust the radius
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Icon(Icons.mic, color: Colors.black),
      ),
    );
  }
}
