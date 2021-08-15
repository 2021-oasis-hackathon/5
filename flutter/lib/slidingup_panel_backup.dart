import 'package:flutter/material.dart';
import 'package:qount/Qr_reading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'map.dart';


class sliding_home extends StatelessWidget {
  const sliding_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sliding()
    );
  }
}

class sliding extends StatefulWidget {
  const sliding({Key? key}) : super(key: key);

  @override
  _slidingState createState() => _slidingState();
}


class _slidingState extends State<sliding> {
  int _selectedIndex = 0;
  List<Widget> _widgetoptions = <Widget>[
    Text(
      'Index 0: shop',
    ),
    qr_reading(),
    Text(
      'Index 2: Mypage',
    ),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SlidingUpPanel(
        onPanelSlide: (double pos) => setState((){
          
        }),

        maxHeight: size.height,
        minHeight: 60,
        panel: Center(

          child: _widgetoptions.elementAt(_selectedIndex)
        ),
        body: Center(
          child: KakaoMapTest(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'shop'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'camera'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mypage'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped
        

      ),
    );  }
}

