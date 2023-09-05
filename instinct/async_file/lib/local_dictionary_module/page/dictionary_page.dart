import 'package:async_file/local_dictionary_module/logic/word_logic.dart';
import 'package:async_file/local_dictionary_module/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../content/wordListConstant.dart';
import '../helpers/word_helpers.dart';
import '../modals/word_modal.dart';
import 'add_word.dart';
import 'edit_word.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    WordLoading resetLoading = context.watch<WordLogic>().loadingData;
    Widget loadingWidget = SizedBox();

    if (resetLoading == WordLoading.loading) {
      loadingWidget = Positioned.fill(
          child: Container(
        alignment: Alignment.center,
        color: Colors.black26,
        child: CircularProgressIndicator(),
      ));
    } else {
      loadingWidget;
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
            drawer: _buildDrawer(),
          ),
        ),
        loadingWidget
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.abc,
            size: 150,
            color: Colors.blueAccent,
          )),
          ListTile(
            leading: Icon(Icons.restart_alt_rounded),
            title: Text("Reset Data"),
            onTap: () async {
              context.read<WordLogic>().setResetLoading();
              await context.read<WordLogic>().resetData();
              await context.read<WordLogic>().read();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("Erase All Records"),
            onTap: () {
              Navigator.pop(context);
              context.read<WordLogic>().eraseAllRecords();
            },
          ),
        ],
      ),
    );
  }

  bool englist = true;
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      title: Text("EN-KH Dictionary"),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              englist = !englist;
            });
          },
          icon: Container(
            padding: EdgeInsets.all(5),
            color: englist ? Colors.blueAccent : Colors.deepPurple,
            child: Text(
              englist ? "EN" : "KH",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<WordLogic>().clearSearchWord();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(englist),
              ),
            );
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddWord(),
              ),
            );
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildBody() {
    WordLoading _wordloading = context.read<WordLogic>().loading;
    switch (_wordloading) {
      case WordLoading.none:
      case WordLoading.loading:
        return CircularProgressIndicator();

      case WordLoading.error:
        return Center(
          child: Text("Something went wrong"),
        );
      case WordLoading.done:
        return _buildListView();
    }
  }

  Widget _buildListView() {
    List<WordModel> list = [];
    if (englist) {
      list = context.watch<WordLogic>().wordModelListSortedByEnglish;
    } else {
      list = context.watch<WordLogic>().wordModelListtSortedByKhmer;
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildItem(list[index]);
      },
    );
  }

  Widget _buildItem(WordModel item) {
    if (englist) {
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
    } else {
      return Card(
        child: ListTile(
          title: Text(item.khmer),
          subtitle: Text(item.english),
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
}
