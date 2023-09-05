import 'package:flutter/material.dart';
import 'package:homework01/provider/provider-model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../provider/language_logic.dart';
import '../provider/theme_logic.dart';
import 'Constant/language.dart';
import 'state_detail_page.dart';

class StatePage extends StatefulWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  bool _dark = false;
  Language _language = Language();

  @override
  Widget build(BuildContext context) {
    _dark = context.watch<ThemeLogic>().dark;
    _language = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _dark?Colors.black54: Colors.pinkAccent,
      child: ListView(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.face,
            color: Colors.white,
            size: 100,
          )),
          ListTile(
            leading: Icon(
              Icons.lightbulb_outline,
              color: Colors.white,
            ),
            title: Text(_dark?"Change to Light Mode":"Change to dark mode",
                style: TextStyle(color: Colors.white)),
            trailing: Icon(_dark ? Icons.light_mode : Icons.dark_mode,color: Colors.white,),
            onTap: (){
              context.read<ThemeLogic>().toggleDark();
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: Colors.white),
            title: Text(
              _language.changeLanguage,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              context.read<LanguageLogic>().toggleLanguage();
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor:_dark?Colors.black54: Colors.pinkAccent,
      title: Text(_language.appName),
      actions: [
        IconButton(
            onPressed: () {
              context.read<ThemeLogic>().toggleDark();
            },
            icon: Icon(_dark ? Icons.light_mode : Icons.dark_mode)),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
            duration: Duration(milliseconds:150),
                child: StateDetailPage(_counter), type: PageTransitionType.rightToLeft));
          },
          icon: Icon(Icons.login),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButtons(),
          _buildText(),
        ],
      ),
    );
  }

  int _counter = 0;

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            context.read<CounterLogic>().decrease();
          },
          icon: Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () {
            context.read<CounterLogic>().increase();
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Container(
      child: Text(
        "Counter: ${context.watch<CounterLogic>().counter}",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
