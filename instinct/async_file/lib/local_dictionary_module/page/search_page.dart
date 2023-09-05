import 'package:async_file/local_dictionary_module/logic/word_logic.dart';
import 'package:async_file/local_dictionary_module/modals/word_modal.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'edit_word.dart';

class SearchPage extends StatefulWidget {
  final bool english;
  SearchPage(this.english);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: _buildSearchTextField(),
      ),
      body: _buildbody(),
    );
  }

  var _searchController = TextEditingController(text: "");
  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.english ? "Search" : "ស្វែងរក",
          hintStyle: TextStyle(
            color: Colors.white70,
          )),
      onChanged: (text) {
        if (widget.english) {
          context.read<WordLogic>().searchEnglish(text);
        } else {
          context.read<WordLogic>().searchKhmer(text);
        }
      },
    );
  }

  Widget _buildbody() {
    return Container(
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    List<WordModel> listItem = [];
    if(widget.english){
      listItem= context.watch<WordLogic>().searchwordEnglish;
    }else{
      listItem= context.watch<WordLogic>().searchwordKhmer;
    }
    return ListView.builder(
      itemCount: listItem.length,
      itemBuilder: (context, index) {
        return _buildItem(listItem[index]);
      },
    );
  }

  Widget _buildItem(WordModel item) {
    return Card(
      child: ListTile(
        title: Text(item.english),
        subtitle: Text(item.khmer),
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
                child: EditWordPage(item),
                type: PageTransitionType.bottomToTop,
                fullscreenDialog: true),
          );
        },
      ),
    );
  }
}
