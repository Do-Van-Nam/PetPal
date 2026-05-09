import 'package:demo_app/main/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main/ui/home/home_page.dart';
import 'main/ui/splash/splash_page.dart';

const String PATH_SPLASH = "/";

const String PATH_HOME = "/main";
const String PATH_PROFILE = "/profile";
const String PATH_ACTIVITY = "/activity";

// auth
const String PATH_LOGIN = "/login";
const String PATH_SIGNUP = "/signup";
const String PATH_FORGOT_PASSWORD = "/forgot-password";
const String PATH_RESET_PASSWORD = "/reset-password";
const String PATH_VERIFY_OTP = "/verify-otp";
const String PATH_LANGUAGE = "/language";
//driver auth

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: PATH_SPLASH,

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: PATH_HOME,
                builder: (_, __) {
                  return HomePage();
                }),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: PATH_ACTIVITY, builder: (_, __) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: PATH_PROFILE, builder: (_, __) => HomePage()),
          ],
        ),
      ],
    ),
    GoRoute(
      path: PATH_SPLASH,
      builder: (context, state) => const SplashPage(),
    ),
  ],
  // redirect: (context, state) {
  //   final isLoggedIn = UserInfoModel.instance.username.isNotEmpty;
  //   final isFirstOpenApp = AppConfig.instance.isFirstOpenApp;
  //
  //   AppLogger().logError(
  //     "CheckApp: isLoggedIn=$isLoggedIn, isFirstOpenApp=$isFirstOpenApp",
  //   );
  //
  //   // if (isLoggedIn && state.matchedLocation != PATH_HOME) {
  //   //   return PATH_HOME;
  //   // }
  //
  //   if (!isLoggedIn && state.matchedLocation == PATH_LOGIN) {
  //     if (isFirstOpenApp) {
  //       return PATH_HOME;
  //     } else {
  //       return PATH_LOGIN;
  //     }
  //   }
  //
  //   return null;
  // },
);
