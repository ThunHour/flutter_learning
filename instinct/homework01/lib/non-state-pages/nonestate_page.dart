import 'package:flutter/material.dart';

import 'nonestate_detail_page.dart';

class NoneStatePage extends StatefulWidget {
  const NoneStatePage({Key? key}) : super(key: key);

  @override
  _NoneStatePageState createState() => _NoneStatePageState();
}

class _NoneStatePageState extends State<NoneStatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("None State Page"),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoneStateDetailPage(_counter),
              ),
            );
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
            setState(() {
              _counter--;
            });
          },
          icon: Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Container(
      child: Text(
        "Counter: $_counter",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
