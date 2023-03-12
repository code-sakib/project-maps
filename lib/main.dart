import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapbox_turn_by_turn/core/authentication/auth_page.dart';
import 'package:mapbox_turn_by_turn/core/authentication/forget_password_page.dart';
import 'package:mapbox_turn_by_turn/core/authentication/verification_page.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';
import 'package:mapbox_turn_by_turn/data/bloc/map_bloc.dart';
import 'package:mapbox_turn_by_turn/data/bloc/weather_bloc.dart';
import 'package:mapbox_turn_by_turn/data/users_location.dart';
import 'package:mapbox_turn_by_turn/firebase_options.dart';
import 'package:mapbox_turn_by_turn/ui/pages/go_to_page.dart';
import 'package:mapbox_turn_by_turn/ui/pages/home_page.dart';
import 'package:mapbox_turn_by_turn/ui/pages/setting_page.dart';
import 'package:mapbox_turn_by_turn/ui/pages/turn_by_turn_navigation.dart';
import 'package:mapbox_turn_by_turn/ui/pages/weather_page.dart';

import 'core/theme/themeing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialLocationAndSave();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MapBloc(), child: const HomePage()),
        BlocProvider(
            create: (context) => WeatherBloc(), child: const WeatherPage()),
        BlocProvider(
            create: (context) => CitiesBloc(), child: const WeatherPage()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffolfMessengerKey,
        title: 'Maps',
        theme: AppTheme.mainTheme,
        onGenerateRoute: AppRouter.getGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}

class AppRouter {
  static Route? getGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MainPage());
      case '/auth_page':
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case '/forget_pass_page':
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordPage());
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/settings':
        return MaterialPageRoute(builder: (context) => const SettingPage());
      case '/goto':
        return MaterialPageRoute(builder: (context) => const GoTo());
      case '/weather':
        return MaterialPageRoute(
          builder: (context) => const WeatherPage(),
        );
      case '/navigate':
        return MaterialPageRoute(
          builder: (context) => const TurnByTurn(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const AuthPage(),
        );
    }
  }
}

class MainPage extends StatelessWidget {
  const MainPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const VerificationPage();
            } else if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
