import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: TapTapApp(),
    ),
  );
}

class TapTapApp extends StatefulWidget {
  const TapTapApp({super.key});

  @override
  State<TapTapApp> createState() => _TapTapAppState();
}

class _TapTapAppState extends State<TapTapApp> {
  bool _showSplash = true;

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapTap',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _showSplash
          ? SplashScreen(onComplete: _onSplashComplete)
          : const HomeScreen(),
    );
  }
}
