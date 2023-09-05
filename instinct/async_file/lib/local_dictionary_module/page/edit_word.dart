import 'package:async_file/local_dictionary_module/logic/word_logic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../modals/word_modal.dart';
import '../util/message_util.dart';

class EditWordPage extends StatefulWidget {
  final WordModel item;
  EditWordPage(this.item);

  @override
  State<EditWordPage> createState() => _EditWordPageState();
}

class _EditWordPageState extends State<EditWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Word"),
        backgroundColor: Colors.indigo,
      ),
      body: _buildbody(),
    );
  }

  late var _engCtrl = TextEditingController(text: widget.item.english);
  late var _khmerCtrl = TextEditingController(text: widget.item.khmer);

  Widget _buildbody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(children: [
        _buildEnglishTextField(),
        _buildKhmerTextField(),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(),
              SizedBox(
                width: 20,
              ),
              _buildDeleteButton()
            ],
          ),
        )
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

  Widget _buildDeleteButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
      onPressed: () {
        context.read<WordLogic>().delete(widget.item);
        context.read<WordLogic>().read();
        Navigator.pop(context);
      },
      icon: FaIcon(FontAwesomeIcons.trashCan),
      label: Text("Delete"),
    );
  }

  Widget _buildButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        WordModel wordModel = WordModel(
          id: widget.item.id,
          english: _engCtrl.text.trim(),
          khmer: _khmerCtrl.text.trim(),
        );

        context.read<WordLogic>().update(wordModel);
        Navigator.pop(context);

        showSnackBar(context, "word edit successfully");
        context.read<WordLogic>().read();
      },
      icon: FaIcon(
        FontAwesomeIcons.penToSquare,
        size: 15,
      ),
      label: Text("Update"),
    );
  }
}
