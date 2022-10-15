import 'package:flutter/material.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.home,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.account_circle,
      size: 150,
    ),
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
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
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
            icon: TabBarIcon(Icons.account_circle, "Account", 2),
            label: 'Account',
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
