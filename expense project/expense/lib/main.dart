import 'package:expense/logic/expense_logic.dart';
import 'package:expense/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'logic/categry_logic.dart';
import 'logic/login_logic.dart';
import 'logic/signin_logic.dart';
import 'logic/token.dart';
void main() {
  runApp(ExpenseApp());
}
class ExpenseApp extends StatelessWidget {
  Color _primaryColor = HexColor('#645fd0');
  Color _accentColor = HexColor('#8380d6');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginLogic()),
        ChangeNotifierProvider(create: (context) => Token()),
        ChangeNotifierProvider(create: (context) => SigninLogic()),
        ChangeNotifierProvider(create: (context) => CategoryLogic()),
        ChangeNotifierProvider(create: (context) => ExpenseLogic())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          fontFamily: 'roboto',
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
