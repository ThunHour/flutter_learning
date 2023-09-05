import 'package:async_file/cache_module/logic/secure_cache.dart';
import 'package:async_file/cache_module/logic/sharePreferance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/file_logic.dart';
import 'my_cache_page.dart';

class MyCacheSplashScreen extends StatefulWidget {
  const MyCacheSplashScreen({Key? key}) : super(key: key);
  @override
  State<MyCacheSplashScreen> createState() => _MyCacheSplashScreenState();
}

class _MyCacheSplashScreenState extends State<MyCacheSplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      await context.read<FileLogic>().readdata();
      await context.read<PreLogic>().readTeme();
      await context.read<SecureCache>().readTheme();
      // await  context.read<RandomUserLogic>().readAllData();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyCachePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        child: Icon(Icons.account_circle, size: 100),
      ),
    );
  }
}
