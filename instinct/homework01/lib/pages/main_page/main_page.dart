import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sub_page/home_page.dart';
import '../sub_page/menu_page.dart';
import '../sub_page/play_page.dart';
import '../sub_page/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello")),
      body: _buildBody(),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  PageController _pageController = new PageController();
  Widget _buildBody() {
    return Container(
      child: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: [HomePage(), PlayPage(), ProfilePage(), MenuPage()],
      ),
    );
  }

  int _currentIndex = 0;
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
      // showUnselectedLabels: false,
      // showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: "Play"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Menu"),
      ],
    );
  }
}
