import 'package:flutter/material.dart';
// import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  'QuectoVision',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
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
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Modern Healthcare Backbone',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
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
                SizedBox(
                  height: 75,
                ),
              ],
            ),
            // AnimatedButton(
            //   text: "Studio",
            //   width: 125,
            //   height: 45,
            //   transitionType: TransitionType.LEFT_TO_RIGHT,
            //   isReverse: false,
            //   selectedBackgroundColor: Colors.black,
            //   borderColor: Colors.black,
            //   borderRadius: 50,
            //   borderWidth: 2,
            //   textStyle: const TextStyle(
            //       fontFamily: 'SF Pro Display',
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.black87,
            //       shadows: [
            //         Shadow(
            //           blurRadius: 1.0,
            //           color: Colors.grey,
            //           offset: Offset(1.0, 1.0),
            //         ),
            //       ],
            //     ),
            //   onPress: () {
            //     context.go("/scribe");
            //   },
            // ),
            InkWell(
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
          ],
        ),
      ),
    );
  }
}
