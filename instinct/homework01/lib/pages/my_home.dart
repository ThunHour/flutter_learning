import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _hidePasswrd = true;
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: InkWell(
        child: _buildBody(),
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
      ),
      drawer: _buildDrawer(),
    );
  }

  String _logo = "https://img.icons8.com/dusk/512/genshin-impact-logo.png";

  AppBar _buildAppBar() {
    return AppBar(
      leading: Icon(
        Icons.settings,
        color: _dark ? Colors.red : Colors.white,
      ),
      backgroundColor:
          _dark ? Colors.black.withOpacity(0.8) : Colors.red.withOpacity(0.7),
      centerTitle: true,
      title: Text("Let's Watch",
          style: TextStyle(color: _dark ? Colors.red : Colors.white)),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _dark = !_dark;

            });
          },
          icon: Icon(
            _dark ? Icons.dark_mode : Icons.light_mode,
            color: _dark ? Colors.red : Colors.white,
          ),
        )
      ],

      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const FaIcon(FontAwesomeIcons.facebook),
      //     color: Colors.white,
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: const FaIcon(FontAwesomeIcons.share),
      //     color: Colors.white,
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.settings),
      //     color: Colors.white,
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: _buildImage(_pic),
      //     color: Colors.white,
      //   ),
      // ],
    );
  }

  String _pic =
      "https://staticg.sportskeeda.com/editor/2021/12/3e655-16387462705082-1920.jpg";

  Widget _buildBody() {
    return Container(
      color: _dark?Colors.black.withOpacity(0.1):Colors.red.withOpacity(0.1),
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildGmailField(),_buildPassword(), _buildElevatedButton()]),
    );
  }

  Widget _buildElevatedButton() {
    return Container(
      margin: EdgeInsets.only(top:20),
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary:
              _dark ? Colors.black.withOpacity(0.8):Colors.red.withOpacity(0.7),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        label: Text("Register",
            style: TextStyle(color: _dark ?  Colors.red: Colors.white)),
        icon: Icon(Icons.person_add,color: _dark ?  Colors.red: Colors.white),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          primary: Colors.red,
          textStyle: TextStyle(
            fontSize: 30,
          ),
        ),
        label: Text(
          "Register",
        ),
        icon: Icon(Icons.person_add));
  }

//text with circle
// Widget _buildImage() {
//   return Container(
//     alignment: Alignment.center,
//     child: Container(
//         width: 200,
//         height: 200,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.orange,
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0B1DF6),
//               Color(0xFFE400B8),
//               Color(0xFFFF0076),
//               Color(0xFFFF6D45),
//               Color(0xFFFFBB39),
//               Color(0xFFF9F871)
//             ],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               offset: Offset(10, 20),
//               spreadRadius: 10,
//               blurRadius: 20,
//             )
//           ],
//         ),
//         child: const Text("Genshin",
//             style: TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white))),
//   );
// }

  Widget _buildImage(String picture, {double diameter = 300}) {
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.red,
        image: DecorationImage(
          image: NetworkImage(picture),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _buildSearch() {
    final nameHolder = TextEditingController();
    clearText() {
      nameHolder.clear();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: Colors.black.withOpacity(0.6)),
      child: TextField(
        controller: nameHolder,
        style: TextStyle(color: Colors.white),
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search",
            border: InputBorder.none,
            hintStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: clearText,
            )),
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color:
            _dark ? Colors.black.withOpacity(0.8) : Colors.red.withOpacity(0.7),
      ),
      child: TextField(
        style: TextStyle(color: _dark ? Colors.red.withOpacity(0.9) : Colors.black.withOpacity(0.9)),
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        obscureText: _hidePasswrd,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: _dark ? Colors.red : Colors.white),
          hintText: "Enter the Password here.",
          border: InputBorder.none,
          hintStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
          suffixIcon: IconButton(
              icon: Icon(_hidePasswrd?Icons.visibility:Icons.visibility_off, color: _dark ? Colors.red : Colors.white),
              onPressed: () {
                setState(() {
                  _hidePasswrd=!_hidePasswrd;
                });
              }),
        ),
      ),
    );
  }

  Widget _buildGmailField() {
    final nameHolder = TextEditingController();

    clearTextInput() {
      nameHolder.clear();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        color:
            _dark ? Colors.black.withOpacity(0.8) : Colors.red.withOpacity(0.7),
      ),
      child: TextField(
        controller: nameHolder,
        style: TextStyle(color: _dark ? Colors.red.withOpacity(0.9) : Colors.black.withOpacity(0.9)),
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email, color: _dark ? Colors.red : Colors.white),
          hintText: "Enter the Gmail here.",
          border: InputBorder.none,
          hintStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: _dark ? Colors.red : Colors.white),
              onPressed: clearTextInput),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Icon(Icons.face, size: 100),
        ),
      ]),
    );
  }
}
