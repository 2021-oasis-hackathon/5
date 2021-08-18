import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import '../screens/home/Qr_reading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../screens/home/map.dart';

class sliding_home extends StatelessWidget {
  UserMe me;
  sliding_home({required this.me});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: sliding(me: me));
  }
}

class sliding extends StatefulWidget {
  UserMe me;
  sliding({required this.me});

  @override
  _slidingState createState() => _slidingState(me: me);
}

class _slidingState extends State<sliding> {
  int _selectedIndex = 0;
  final UserMe me;

  _slidingState({required this.me});

  List<Widget> _widgetoptions = <Widget>[
    Text(
      'Index 0: shop',
    ),
    //qr_reading(),
    Text(
      'Index 2: Mypage',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        onPanelSlide: (double pos) => setState(() {}),
        maxHeight: size.height,
        minHeight: 60,
        panel: Center(child: _widgetoptions.elementAt(_selectedIndex)),
        body: Center(
          child: Googlemap_home(me: me),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'shop'),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'camera'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mypage')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped),
    );
  }
}
