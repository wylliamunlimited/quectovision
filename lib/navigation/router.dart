import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp/navigation/routes.dart';

final quectoRouter = GoRouter(
  routes: quectoRoutes,
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: "/",
);
