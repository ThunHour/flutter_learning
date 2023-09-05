import 'package:flutter/material.dart';

class NoneStateDetailPage extends StatefulWidget {
  int counter;

  NoneStateDetailPage(this.counter);

  @override
  _NoneStateDetailPageState createState() => _NoneStateDetailPageState();
}

class _NoneStateDetailPageState extends State<NoneStateDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text("None State Detail Page"),
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
            setState(() {
              widget.counter--;
            });
          },
          icon: Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.counter++;
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
        "Counter: ${widget.counter}",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
