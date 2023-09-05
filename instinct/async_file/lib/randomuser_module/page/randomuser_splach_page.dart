import 'package:async_file/randomuser_module/logic/cache_random_user_logic.dart';
import 'package:async_file/randomuser_module/logic/random_user_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'randomuser_page.dart';


class RandomUserSlashPage extends StatefulWidget {
  const RandomUserSlashPage({Key? key}) : super(key: key);
  @override
  State<RandomUserSlashPage> createState() => _RandomUserSlashPageState();
}

class _RandomUserSlashPageState extends State<RandomUserSlashPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 2), () async {
      await context.read<CacheRamdomLogic>().readMore(refresh: false);
      // await  context.read<RandomUserLogic>().readAllData();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => RandomUserPage()));
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
