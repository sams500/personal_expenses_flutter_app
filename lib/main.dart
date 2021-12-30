import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';
import 'home.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoogleFonts.config.allowRuntimeFetching = false;
    currentAppTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expanses App',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: currentAppTheme.currentThemeMode,
      home: const MyHomePage(),
    );
  }
}

