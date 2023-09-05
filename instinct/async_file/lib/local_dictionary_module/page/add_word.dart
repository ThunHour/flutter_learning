import 'package:async_file/local_dictionary_module/logic/word_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/word_helpers.dart';
import '../modals/word_modal.dart';
import '../util/message_util.dart';

class AddWord extends StatefulWidget {
  const AddWord({Key? key}) : super(key: key);

  @override
  State<AddWord> createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Word"),
        backgroundColor: Colors.purple,
      ),
      body: _buildbody(),
    );
  }

  var _engCtrl = TextEditingController();
  var _khmerCtrl = TextEditingController();

  Widget _buildbody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(children: [
        _buildEnglishTextField(),
        _buildKhmerTextField(),
        _buildButton(),
      ]),
    );
  }

  Widget _buildEnglishTextField() {
    return TextField(
      controller: _engCtrl,
      decoration: InputDecoration(
        hintText: "Enter English Word",
        icon: Text("EN"),
      ),
    );
  }

  Widget _buildKhmerTextField() {
    return TextField(
      controller: _khmerCtrl,
      decoration: InputDecoration(
        hintText: "បញ្ចូលពាក្យខ្មែរ",
        icon: Text("ខ្មែរ"),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        WordModel wordModel = WordModel(
          id: DateTime.now().microsecondsSinceEpoch,
          english: _engCtrl.text.trim(),
          khmer: _khmerCtrl.text.trim(),
        );

        context.read<WordLogic>().insert(wordModel);
        _engCtrl.clear();
        _khmerCtrl.clear();

        showSnackBar(context, "Inserted");
        context.read<WordLogic>().read();
      },
      icon: Icon(Icons.add),
      label: Text("ADD"),
    );
  }
}
