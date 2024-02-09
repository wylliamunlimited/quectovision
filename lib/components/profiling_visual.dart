import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp/model/Patient.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ProfileVisual extends StatefulWidget {
  final Patient patient;
  final Map<String, String> symptom2location;
  // final List<String> highRiskDisease;

  const ProfileVisual({
    super.key,
    required this.patient,
    required this.symptom2location,
    // required this.highRiskDisease,
  });

  @override
  State<ProfileVisual> createState() => _ProfileVisualState();
}

class _ProfileVisualState extends State<ProfileVisual> {
  Map<String, bool> mappedLocation = {
    'head': false,
    'nose': false,
    'mouth': false,
    'throat': false,
    'forehead': false,
    'eyes': false,
    'facecheeks': false,
    'intestines': false,
    'testicles': false,
    'uterus': false,
    'ears': false,
    'chin': false,
    'neck': false,
    'shoulders': false,
    'biceps': false,
    'forearms': false,
    'hands': false,
    'elbows': false,
    'chest': false,
    'abdomen': false,
    'groins': false,
    'hip': false,
    'thighs': false,
    'penis': false,
    'vagina': false,
    'knees': false,
    'calfs': false,
    'ankles': false,
    'foot': false,
    'glutes': false,
    'upper back': false,
    'lower back': false,
    'wrists': false,
    'anus': false,
  };

  Map<String, List<String>> clickables = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("profile result list: ${widget.symptom2location.entries.toString()}");
    for (var entry in widget.symptom2location.entries) {
      print("${entry.key} --> ${entry.value}");
      mappedLocation[entry.value] = true;
      if (!clickables.containsKey(entry.value)) {
        clickables[entry.value] = [];
      }
      clickables[entry.value]!.add(entry.key);
    }

    print("mappedlocations: ${mappedLocation.toString()}");
    print("clickables: ${clickables.toString()}");
    return Container(
      child: Stack(
        children: [
          widget.patient.gender == "male"
              ? Image.asset(
                  "assets/images/male.png",
                  width: 270,
                )
              : Image.asset(
                  "assets/images/female.png",
                  width: 250,
                ),
          // Positioned(
          //       child: rippleHighlight(),
          //       top: 70,
          //       left: 141,
          //     )
          ...SymptomsHighlight(),
          // Positioned(
          //   top: 30,
          //   left: 10,
          //   child: Text(
          //     "Alerts",
          //     style: TextStyle(
                
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<Widget> SymptomsHighlight() {
    if (widget.patient.gender != "male") {
      return [
        mappedLocation["head"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 25),
                top: 50,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["nose"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 70,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["mouth"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 80,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["throat"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 95,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["forehead"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 45,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["eyes"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 55,
                left: 115,
              )
            : SizedBox.shrink(),
        mappedLocation["eyes"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 55,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["facecheeks"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 70,
                left: 112.5,
              )
            : SizedBox.shrink(),
        mappedLocation["facecheeks"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 70,
                left: 137.5,
              )
            : SizedBox.shrink(),
        mappedLocation["ears"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 60,
                left: 150,
              )
            : SizedBox.shrink(),
        mappedLocation["ears"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 60,
                left: 100,
              )
            : SizedBox.shrink(),
        mappedLocation["chin"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 90,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["neck"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 100,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["shoulders"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 125,
                left: 170,
              )
            : SizedBox.shrink(),
        mappedLocation["shoulders"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 125,
                left: 80,
              )
            : SizedBox.shrink(),
        mappedLocation["biceps"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 180,
                left: 60,
              )
            : SizedBox.shrink(),
        mappedLocation["biceps"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 180,
                left: 190,
              )
            : SizedBox.shrink(),
        mappedLocation["forearms"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 240,
                left: 55,
              )
            : SizedBox.shrink(),
        mappedLocation["forearms"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 240,
                left: 195,
              )
            : SizedBox.shrink(),
        mappedLocation["hands"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 310,
                left: 195,
              )
            : SizedBox.shrink(),
        mappedLocation["hands"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 310,
                left: 55,
              )
            : SizedBox.shrink(),
        mappedLocation["elbows"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 215,
                left: 185,
              )
            : SizedBox.shrink(),
        mappedLocation["elbows"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 215,
                left: 65,
              )
            : SizedBox.shrink(),
        mappedLocation["chest"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 30),
                top: 150,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["abdomen"]! || mappedLocation["intestines"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 30),
                top: 240,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["hip"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 240,
                left: 95,
              )
            : SizedBox.shrink(),
        mappedLocation["hip"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 240,
                left: 155,
              )
            : SizedBox.shrink(),
        mappedLocation["groins"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 300,
                left: 130,
              )
            : SizedBox.shrink(),
        mappedLocation["groins"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 300,
                left: 120,
              )
            : SizedBox.shrink(),
        mappedLocation["thighs"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 360,
                left: 150,
              )
            : SizedBox.shrink(),
        mappedLocation["thighs"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 360,
                left: 100,
              )
            : SizedBox.shrink(),
        mappedLocation["vagina"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 300,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["uterus"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 285,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["knees"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 410,
                left: 145,
              )
            : SizedBox.shrink(),
        mappedLocation["knees"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 410,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["calfs"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 450,
                left: 140,
              )
            : SizedBox.shrink(),
        mappedLocation["calfs"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 450,
                left: 110,
              )
            : SizedBox.shrink(),
        mappedLocation["ankles"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 530,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["ankles"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 530,
                left: 115,
              )
            : SizedBox.shrink(),
        mappedLocation["foot"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 540,
                left: 140,
              )
            : SizedBox.shrink(),
        mappedLocation["foot"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 540,
                left: 110,
              )
            : SizedBox.shrink(),
        mappedLocation["glutes"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 285,
                left: 145,
              )
            : SizedBox.shrink(),
        mappedLocation["glutes"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 285,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["upper back"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 130,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["lower back"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 220,
                left: 125,
              )
            : SizedBox.shrink(),
        mappedLocation["wrist"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 290,
                left: 195,
              )
            : SizedBox.shrink(),
        mappedLocation["wrist"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 290,
                left: 65,
              )
            : SizedBox.shrink(),
        mappedLocation["anus"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 300,
                left: 125,
              )
            : SizedBox.shrink(),
      ];
    } else {
      return [
        mappedLocation["head"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 25),
                top: 50,
                left: 134,
              )
            : SizedBox.shrink(),
        mappedLocation["nose"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 80,
                left: 134,
              )
            : SizedBox.shrink(),
        mappedLocation["mouth"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 90,
                left: 134,
              )
            : SizedBox.shrink(),
        mappedLocation["throat"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 105,
                left: 134,
              )
            : SizedBox.shrink(),
        mappedLocation["forehead"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 55,
                left: 134,
              )
            : SizedBox.shrink(),
        mappedLocation["eyes"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 70,
                left: 127,
              )
            : SizedBox.shrink(),
        mappedLocation["eyes"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 70,
                left: 141,
              )
            : SizedBox.shrink(),
        mappedLocation["facecheeks"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 80,
                left: 122,
              )
            : SizedBox.shrink(),
        mappedLocation["facecheeks"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 80,
                left: 147,
              )
            : SizedBox.shrink(),
        mappedLocation["ears"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 75,
                left: 160,
              )
            : SizedBox.shrink(),
        mappedLocation["ears"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 75,
                left: 110,
              )
            : SizedBox.shrink(),
        mappedLocation["chin"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 100,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["neck"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 110,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["shoulders"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 135,
                left: 190,
              )
            : SizedBox.shrink(),
        mappedLocation["shoulders"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 135,
                left: 80,
              )
            : SizedBox.shrink(),
        mappedLocation["biceps"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 190,
                left: 70,
              )
            : SizedBox.shrink(),
        mappedLocation["biceps"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 190,
                left: 200,
              )
            : SizedBox.shrink(),
        mappedLocation["forearms"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 240,
                left: 65,
              )
            : SizedBox.shrink(),
        mappedLocation["forearms"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 240,
                left: 205,
              )
            : SizedBox.shrink(),
        mappedLocation["hands"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 310,
                left: 215,
              )
            : SizedBox.shrink(),
        mappedLocation["hands"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 310,
                left: 55,
              )
            : SizedBox.shrink(),
        mappedLocation["elbows"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 220,
                left: 195,
              )
            : SizedBox.shrink(),
        mappedLocation["elbows"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 220,
                left: 70,
              )
            : SizedBox.shrink(),
        mappedLocation["chest"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 30),
                top: 150,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["abdomen"]! || mappedLocation["intestines"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 30),
                top: 240,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["hip"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 255,
                left: 95,
              )
            : SizedBox.shrink(),
        mappedLocation["hip"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 255,
                left: 175,
              )
            : SizedBox.shrink(),
        mappedLocation["groins"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 315,
                left: 139,
              )
            : SizedBox.shrink(),
        mappedLocation["groins"]!
            ? Positioned(
                child: rippleHighlight(),
                top: 315,
                left: 129,
              )
            : SizedBox.shrink(),
        mappedLocation["thighs"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 350,
                left: 165,
              )
            : SizedBox.shrink(),
        mappedLocation["thighs"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 350,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["penis"]! || mappedLocation["testicles"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 315,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["knees"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 410,
                left: 165,
              )
            : SizedBox.shrink(),
        mappedLocation["knees"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 410,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["calfs"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 440,
                left: 165,
              )
            : SizedBox.shrink(),
        mappedLocation["calfs"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 440,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["ankles"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 510,
                left: 160,
              )
            : SizedBox.shrink(),
        mappedLocation["ankles"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 510,
                left: 110,
              )
            : SizedBox.shrink(),
        mappedLocation["foot"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 530,
                left: 165,
              )
            : SizedBox.shrink(),
        mappedLocation["foot"]!
            ? Positioned(
                child: rippleHighlight(minRadius: 20),
                top: 530,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["glutes"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 300,
                left: 165,
              )
            : SizedBox.shrink(),
        mappedLocation["glutes"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 300,
                left: 105,
              )
            : SizedBox.shrink(),
        mappedLocation["upper back"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromRGBO(138, 63, 63, 0.706)),
                top: 150,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["lower back"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 240,
                left: 135,
              )
            : SizedBox.shrink(),
        mappedLocation["wrists"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 280,
                left: 215,
              )
            : SizedBox.shrink(),
        mappedLocation["wrists"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 280,
                left: 55,
              )
            : SizedBox.shrink(),
        mappedLocation["anus"]!
            ? Positioned(
                child: rippleHighlight(
                    minRadius: 20, color: Color.fromARGB(180, 138, 63, 63)),
                top: 315,
                left: 135,
              )
            : SizedBox.shrink(),
      ];
    }
  }

  Widget rippleHighlight(
      {double minRadius = 10,
      Color color = const Color.fromARGB(132, 255, 56, 34)}) {
    return RippleAnimation(
      color: color,
      delay: const Duration(milliseconds: 300),
      repeat: true,
      minRadius: minRadius,
      ripplesCount: 3,
      duration: const Duration(milliseconds: 6 * 300),
      child: Container(
        color: Colors.transparent,
      ),
    );
  }
}
