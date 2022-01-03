import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './database/sqflite/sqlite_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'home.dart';
import 'models/theme_manager.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key,}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          ThemeData curTheme;
          if (themeManager.isDarkMode) {
            curTheme = AppTheme.dark();
          } else {
            curTheme = AppTheme.light();
          }
          return MaterialApp(
            title: 'Personal Expanses App',
            theme: curTheme,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
