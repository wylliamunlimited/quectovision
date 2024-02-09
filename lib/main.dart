import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mvp/navigation/router.dart';
import 'package:mvp/pages/home_screen.dart';

void main() {
  runApp(const Demo());
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QuectoVision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
        }),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 84, 237, 130)),
        useMaterial3: true,
      ),
      routerConfig: quectoRouter,
    );
  }
}
