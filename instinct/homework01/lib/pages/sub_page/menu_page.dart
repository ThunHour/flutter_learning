import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant/movieList_constant.dart';
import '../../model/movie_model.dart';
import '../movieDetail.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: ListView(
          children: [
            DrawerHeader(

                child: Icon(
              Icons.person,
              size: 200,
            )),
            Card(
              margin: EdgeInsets.only(top: 100),
              child: ListTile(
                leading: Icon(Icons.face),
                title: Text("Profile"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.login),
                title: Text("Login"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
