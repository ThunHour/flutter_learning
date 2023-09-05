import 'package:flutter/material.dart';
import 'package:homework01/pages/children_page.dart';
import 'package:homework01/pages/main_page/main_page.dart';
import 'package:homework01/pages/my_home.dart';
import 'package:homework01/pages/tiktokPage.dart';
import 'package:homework01/provider/language_logic.dart';
import 'package:homework01/provider/provider-model.dart';
import 'package:homework01/provider/theme_logic.dart';
import 'package:homework01/stateManagement-pages/state_page.dart';
import 'package:provider/provider.dart';
import 'non-state-pages/nonestate_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CounterLogic()),
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
      ChangeNotifierProvider(create: (context) => LanguageLogic())
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: MainPage()));
  }
}
