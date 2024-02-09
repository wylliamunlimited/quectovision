import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  FadeTransitionPage({
    required Widget child,
    LocalKey? key,
  }):super(
     key: key,
     transitionDuration: Duration(seconds: 1),
     child: child,
     transitionsBuilder: (context, animation, secondaryAnimation, child) {
       return FadeTransition(
         opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
         child: child,
       );
     },
   );
}
