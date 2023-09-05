import 'package:async_file/local_dictionary_module/logic/word_logic.dart';
import 'package:async_file/randomuser_module/logic/cache_random_user_logic.dart';
import 'package:async_file/randomuser_module/logic/random_user_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dictionary_page.dart';

class SplashPageDB extends StatefulWidget {
  const SplashPageDB({Key? key}) : super(key: key);
  @override
  State<SplashPageDB> createState() => _SplashPageDBState();
}

class _SplashPageDBState extends State<SplashPageDB> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      await context.read<WordLogic>().read();

      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DictionaryPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        child: Icon(Icons.abc, size: 150),
      ),
    );
  }
}
