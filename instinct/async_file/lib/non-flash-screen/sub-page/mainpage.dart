import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../helper/photo_helper.dart';

import '../model/photo_model.dart';
import 'my_detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future hello(String name) async {
    print("hello $name");
  }

  void show() {
    print("Show something");
  }

  _showSnackBar() {
    Future.delayed(Duration(seconds: 5), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Hello"),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    hello("kimhour");
    show();
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildbody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: _showSnackBar,
          icon: Icon(Icons.info_outline),
        )
      ],
      title: Text("My Async Page"),
    );
  }

  Future<String> _loopSum(int max) {
    return compute(_loopNumber, max);
  }

  Future<String> _getFakeData() async {
    return Future.delayed(Duration(seconds: 1), () {
      return "Some data";
    });
  }

  Widget _buildbody() {
    return Container(
      alignment: Alignment.center,
      child: _buildFuture(),
    );
  } 

  Widget _buildFuture() {
    return FutureBuilder<List<Photomodel>>(
      future: PhotoHelper.readData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("${snapshot.error}");
          return Container(
            padding: EdgeInsets.all(20),
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildOutput(snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildOutput(List<Photomodel> item) {
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        return _buildItem(item[index]);
      },
    );
  }

  Widget _buildItem(Photomodel item) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(item.thumbnaiUrl),
        ),
        title: Text(item.title),
        trailing: Text("${item.albumId}"),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyDetailPage(item)));
        },
      ),
    );
  }
}

String _loopNumber(int max) {
  int total = 0;

  for (int index = 0; index < max; index++) {
    total += index;
  }
  return total.toString();
}
