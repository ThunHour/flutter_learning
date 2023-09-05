import 'package:flutter/material.dart';

import '../model/photo_model.dart';

class MyDetailPage extends StatelessWidget {
  final Photomodel photomodel;
  MyDetailPage(this.photomodel);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Detail page"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.title),
                title: Text("${photomodel.id}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.title),
                title: Text("${photomodel.albumId}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.title),
                title: Text("${photomodel.title}"),
              ),
            ),
  
            Card(

              child: ListTile(
                
                leading: Icon(Icons.title),
                title: Image.network(photomodel.thumbnaiUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}

