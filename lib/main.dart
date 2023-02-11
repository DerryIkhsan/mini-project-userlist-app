import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mini_project_arkamaya/theme.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'pages/list_user.dart';
import 'pages/create_user.dart';
import 'pages/about.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [
    ListUser(),
    CreateUser(),
    About(),
  ];

  final List<String> _pageTitle = ['List Users', 'Create', 'About'];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        body: _pages[_currentPage],
        bottomNavigationBar: Container(
          color: purpleColor.withOpacity(.6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GNav(
              selectedIndex: _currentPage,
              iconSize: 25,
              gap: 8,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: purpleColor,
              onTabChange: (value) {
                _currentPage = value;
                setState(() {});
              },
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabs: [
                GButton(
                  icon: Icons.person,
                  text: 'List Users',
                ),
                GButton(
                  icon: Icons.add,
                  text: 'New',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'About',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
