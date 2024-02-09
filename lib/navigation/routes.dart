import 'package:go_router/go_router.dart';
import 'package:mvp/model/SymptomProfile.dart';
import 'package:mvp/pages/home_screen.dart';
import 'package:mvp/pages/load_screen.dart';
import 'package:mvp/pages/profiling_screen.dart';
import 'package:mvp/pages/scribe_screen.dart';
import 'package:mvp/utils/actions_enum.dart';

enum Routes { home, scribe, load, profiling }

final home_route = GoRoute(
  path: "/",
  builder: (context, state) => HomeScreen(),
  // pageBuilder: (context, state) => FadeTransitionPage(
  //   child: HomeScreen(),
  // ),
);

final scribe_route = GoRoute(
  path: "/scribe",
  builder: (context, state) => ScribeScreen(),
  // pageBuilder: (context, state) => FadeTransitionPage(
  //   child: ScribeScreen(),
  // ),
);

final load_route = GoRoute(
  path: "/loading/:id",
  builder: (context, state) => LoadingScreen(
    audioID: state.pathParameters["id"]!,
  ),
  // pageBuilder: (context, state) => FadeTransitionPage(
  //   child: LoadingScreen(),
  // ),
);

final profiling_route = GoRoute(
  path: "/profiling",
  builder: (context, state) {
    final symptomProfile = state.extra! as Map<String, String>;
      return ProfilingScreen(symptomProfile: symptomProfile);}
  // pageBuilder: (context, state) {
  //   return FadeTransitionPage(
  //     child: ProfilingScreen(profilingID: state.pathParameters["id"]),
  //   );
  // },
);

final quectoRoutes = [
  home_route,
  scribe_route,
  load_route,
  profiling_route,
];
