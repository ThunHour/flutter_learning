import 'dart:async';
import 'dart:ffi';

import 'package:assignment2/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../logic/shop_logic.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double percent = 0.0;
  @override
  void initState() {
    Timer timer;
    Future.delayed(Duration(seconds: 3), () async {
      context.read<ShopLogic>().readData();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Stack(children: [
      Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              child: Image.network(
                "https://icons.iconarchive.com/icons/paomedia/small-n-flat/256/shop-icon.png",
              ),
            ),
          ],
        ),
      ),
      Positioned(
          bottom: 250,
          left: 100,
          child: Container(
            padding: EdgeInsets.all(25),
            width: 200,
            height: 70,
            child: Expanded(
                child: SizedBox(
                    height: 50,
                    child: LinearPercentIndicator(
                      barRadius: Radius.circular(12),
                      lineHeight: 20,
                      percent: 1,
                      animation: true,
                      animationDuration: 2600,
                      progressColor: Colors.red,
                      backgroundColor: Colors.red[100],//text inside bar
                    ))),
          ))
    ]));
  }
}
