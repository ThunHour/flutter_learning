import 'package:expense/page/subpage/category_page.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'subpage/profile_page.dart';

import 'subpage/home_page.dart';

class MainController extends StatefulWidget {
  final userGmail;
  MainController(this.userGmail);
  @override
  State<StatefulWidget> createState() {
    return _MainControllerState();
  }
}

class _MainControllerState extends State<MainController> {
  int _currentIndex = 0;
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  Widget _buildBody() {
    return PageView(
        physics: NeverScrollableScrollPhysics(),
       
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: [HomePage(), CategoryPage(), ProfilePage(widget.userGmail)],
      
    );
  }

  Widget _buildButtonNavigationBar() {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.jumpToPage(_currentIndex);
      },
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.red, size: 40),
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.blueGrey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.diagramPredecessor), label: "Add"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
