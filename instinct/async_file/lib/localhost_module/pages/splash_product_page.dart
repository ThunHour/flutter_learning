import 'package:async_file/localhost_module/logic/product_logic.dart';
import 'package:async_file/localhost_module/logic/upload_image_logic.dart';
import 'package:async_file/localhost_module/pages/product_page.dart';
import 'package:async_file/randomuser_module/logic/cache_random_user_logic.dart';
import 'package:async_file/randomuser_module/logic/random_user_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_upload_page.dart';

class ProdcutSplashPage extends StatefulWidget {
  const ProdcutSplashPage({Key? key}) : super(key: key);
  @override
  State<ProdcutSplashPage> createState() => _ProdcutSplashPageState();
}

class _ProdcutSplashPageState extends State<ProdcutSplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      await context.read<ProductLogic>().read();
      await context.read<UploadImageLogic>().read();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProductPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        child: Icon(Icons.shopping_cart, size: 100),
      ),
    );
  }
}
