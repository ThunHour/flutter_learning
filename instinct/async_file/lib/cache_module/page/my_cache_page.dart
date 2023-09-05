import 'package:async_file/cache_module/logic/secure_cache.dart';
import 'package:async_file/cache_module/logic/sharePreferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../logic/file_logic.dart';

class MyCachePage extends StatefulWidget {
  MyCachePage({Key? key}) : super(key: key);

  @override
  State<MyCachePage> createState() => _MyCachePageState();
}

class _MyCachePageState extends State<MyCachePage> {
  bool _dark = false;
  @override
  Widget build(BuildContext context) {
    _dark = context.watch<SecureCache>().dark;
    return Scaffold(
      backgroundColor: _dark ? Colors.grey : Colors.blue[200],
      appBar: _buildAppBar(),
      body: _buildbody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _dark ? Colors.black : Colors.blue,
      title: Text("My Cache Page"),
      actions: [
        IconButton(
          onPressed: () {
            context.read<FileLogic>().decrease();
          },
          icon: Icon(CupertinoIcons.minus),
        ),
        IconButton(
          onPressed: () {
            context.read<FileLogic>().increase();
          },
          icon: Icon(CupertinoIcons.plus),
        ),
        IconButton(
          onPressed: () {
            context.read<SecureCache>().switchTheme();
          },
          icon: Icon(_dark ? Icons.light_mode : Icons.dark_mode),
        )
      ],
    );
  }

  Widget _buildbody() {
    int count = context.watch<FileLogic>().counter;
    return Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Text(
          "An article is a word that is used to indicate that a noun is a noun without describing it. For example, in the sentence Nick bought a dog, the article a indicates that the word dog is a noun. Articles can also modify anything that acts as a noun, such as a pronoun or a noun phrase.",
          style: TextStyle(
              fontSize: 20 + count.toDouble(),
              color: _dark ? Colors.grey[100] : Colors.black),
        ));
  }
}
