import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './database/moor/moor_db.dart';

import 'app_theme.dart';
import 'home.dart';
import 'theme_manager.dart';

void main() {
  TransactionDatabase db = TransactionDatabase();
  runApp(MyApp(db:db));
}

class MyApp extends StatefulWidget {
  TransactionDatabase db;
  MyApp({
    Key? key, required this.db
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        Provider<TransactionDao>(
            create: (context) => TransactionDao(widget.db),
        )
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
