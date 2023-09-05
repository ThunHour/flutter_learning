import 'package:flutter/material.dart';
import 'package:homework01/provider/theme_logic.dart';
import 'package:provider/provider.dart';

import '../provider/language_logic.dart';
import '../provider/provider-model.dart';
import 'Constant/language.dart';

class StateDetailPage extends StatefulWidget {
  int counter;

  StateDetailPage(this.counter);

  @override
  _StateDetailPageState createState() => _StateDetailPageState();
}

class _StateDetailPageState extends State<StateDetailPage> {
  bool _dark=false;
  Language _language = Language();

  @override
  Widget build(BuildContext context) {
    _dark=context.watch<ThemeLogic>().dark;
    _language = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor:_dark?Colors.black:Colors.pink,
      title: Text(_language.detailPageName),
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
