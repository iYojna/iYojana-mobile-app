import 'package:flutter/material.dart';
import 'package:iyojana/chat/chat_screen.dart';
import 'package:iyojana/scheme/all_scheme_widget.dart';

import 'dashboard/dashboard.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  static  List<Widget> _pages = <Widget>[
    Dashboard(),
    ChatScreen(),
    AllSchemesListView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget TabBarIcon(IconData icon, String text, int index) {
    final bool isSelected = (index == _selectedIndex);

    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (isSelected
                ? const Color.fromARGB(255, 227, 255, 217)
                : Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(text,
                    style: TextStyle(
                      color: (isSelected ? Colors.green : Colors.black),
                    )),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: TabBarIcon(Icons.home, "Home", 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: TabBarIcon(Icons.chat, "Chatbot", 1),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: TabBarIcon(Icons.account_circle, "Scheme", 2),
            label: 'All Schemes',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // dont show label
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
