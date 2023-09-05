import 'package:expense/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatefulWidget {
  final userGmail;
  ProfilePage(this.userGmail);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override void initState() { super.initState(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                color: HexColor("#645fd0"),
              ),
              clipper: CustomClipPath(),
            ),
            Positioned(
              top: 140,
              left: 140,
              child: Container(
                height: 90,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(47, 0, 0, 0),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(200))),
                child: FaIcon(
                  FontAwesomeIcons.userLarge,
                  size: 50,
                  color: HexColor("#645fd0"),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            color: HexColor("#645fd0"),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.envelope,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    "${widget.userGmail}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            color: HexColor("#645fd0"),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.lock,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    "Change Passsword",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            color: HexColor("#645fd0"),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.userLock,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    "Privacy",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            color: HexColor("#645fd0"),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    "Help & Support",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => LoginPage()),);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
              color: HexColor("#645fd0"),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                     Icon(
                     FontAwesomeIcons.arrowRightFromBracket,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
