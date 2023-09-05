import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/post_logic.dart';
import 'Postpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 2), () async {
      await context.read<PostLogic>().readMore(false);
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PostPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Icon(Icons.face, size: 100),
      ),
    );
  }
}
