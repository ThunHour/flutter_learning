import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool dark = false;

  String image =
      "https://cdn1.epicgames.com/salesEvent/salesEvent/EGS_GenshinImpact_miHoYoLimited_S2_1200x1600-c12cdcc2cac330df2185aa58c508e820";

  String logo =
      "https://upload.wikimedia.org/wikipedia/en/thumb/5/5d/Genshin_Impact_logo.svg/2560px-Genshin_Impact_logo.svg.png";
  String darkLogo="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxrz6n_UfKvQz5bPPfrkXEGvgwNZIrR5EYBCn1DD_gqSOE1NlguP6iaivAOUkKgqo9NRU&usqp=CAU";
  String darklogo="https://genshin.hoyoverse.com/_nuxt/img/09cac33.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 250,
        child: Drawer(
          child: Container(
            color:dark == true ? Colors.black : Colors.white,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.network(dark==true?darklogo:logo,height: 50,width: 60,),
                ),
                ListTile(
                  leading: Icon(Icons.home,
                      color: dark == true ? Colors.white : Colors.black),
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: dark == true ? Colors.white : Colors.black),
                  ),
                  trailing: Icon(Icons.navigate_next,
                      color: dark == true ? Colors.white : Colors.black),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.call,
                      color: dark == true ? Colors.white : Colors.black),
                  title: Text(
                    "Contact",
                    style: TextStyle(
                        color: dark == true ? Colors.white : Colors.black),
                  ),
                  trailing: Icon(Icons.navigate_next,
                      color: dark == true ? Colors.white : Colors.black),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: dark == true ? Colors.black : Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.widgets_sharp,
                color: dark == true ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          "Genshin Impact",
          style: TextStyle(
            color: dark == true ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill,
                  color: dark == true ? Colors.white : Colors.black)),
          IconButton(
              onPressed: () {
                setState(() {
                  dark = !dark;
                });
              },
              icon: Icon(dark ? Icons.light_mode : Icons.dark_mode,
                  color: dark == true ? Colors.white : Colors.black))
        ],
      ),
      body: Container(
        color:   dark == true ? Colors.black : Colors.white,
        alignment: Alignment.center,
        child: Image.network(
          image,
          height: 600,
          width: 400,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        color:  dark == true ? Colors.black : Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.home,
                    color: dark == true ? Colors.white : Colors.black)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.person,
                    color: dark == true ? Colors.white : Colors.black)),
            SizedBox(width: 200),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_arrow,
                    color: dark == true ? Colors.white : Colors.black)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz,
                    color: dark == true ? Colors.white : Colors.black)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: dark == true ? Colors.blueGrey : Colors.black,
        child:  Icon(Icons.add_a_photo_sharp, color: dark == true ? Colors.black : Colors.white),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
