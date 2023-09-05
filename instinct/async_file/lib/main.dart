import 'package:async_file/localhost_module/logic/image_logic.dart';
import 'package:async_file/localhost_module/logic/product_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'localhost_module/logic/upload_image_logic.dart';
import 'localhost_module/pages/image_upload_page.dart';
import 'localhost_module/pages/splash_product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => ProductLogic())),
          ChangeNotifierProvider(create: ((context) => ImageLogic())),
          ChangeNotifierProvider(create: ((context) => UploadImageLogic()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:ProdcutSplashPage (),
        ));
  }
}
