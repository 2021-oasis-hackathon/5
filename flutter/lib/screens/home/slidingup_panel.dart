import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/home/my.dart';
import 'package:qount/screens/shop/shop.dart';
import 'Qr_reading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'map.dart';

class sliding_home extends StatefulWidget {
  UserMe me;
  sliding_home({required this.me});

  @override
  _sliding_homeState createState() => _sliding_homeState(me: me);
}

class _sliding_homeState extends State<sliding_home> {
  UserMe me;
  _sliding_homeState({required this.me});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sliding(me: me),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}

class sliding extends StatefulWidget {
  UserMe me;
  sliding({required this.me});

  @override
  _slidingState createState() => _slidingState(me: me);
}

class _slidingState extends State<sliding> {
  UserMe me;
  _slidingState({required this.me});
  PanelController _pc = new PanelController();

  int _selectedIndex = 0;
  bool _camera_ready = false;

  void _onItemTapped(int index) {
    setState(() {
      _camera_ready = false;
      _selectedIndex = index;
      if (_pc.panelPosition < 0.1) {
        _pc.open();
        _pc.animatePanelToPosition(0.1, duration: Duration(milliseconds: 500));
      }
    });
  }

  void _cam_is_ready() {
    setState(() {
      _camera_ready = true;
    });
  }

  void _cam_isnot_ready() {
    setState(() {
      _camera_ready = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SlidingUpPanel(
          panelSnapping: false,
          controller: _pc,
          onPanelOpened: () {
            _cam_is_ready();
          },
          onPanelClosed: () {
            _cam_isnot_ready();
          },
          maxHeight: 640,
          minHeight: 0,
          parallaxOffset: .5,
          panelBuilder: (sc) => _panel(sc, _selectedIndex, _camera_ready),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          body: Center(
            child: Googlemap_home(me: me),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined), label: 'shop'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt_outlined), label: 'camera'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Mypage')
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blueAccent,
              onTap: _onItemTapped),
        ));
  }

  Widget _panel(ScrollController sc, int _selectedIndex, bool _camera_ready) {
    if (_selectedIndex == 1 && !_camera_ready) {
      return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            controller: sc,
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Scan Qr code of the shop",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
            ],
          ));
    }
    if (_selectedIndex == 1 && _camera_ready) {
      return qr_reading();
    }
    if (_selectedIndex == 0) {
      return MediaQuery.removePadding(
          context: context, removeTop: false, child: ShopGridView(me: me));
    }
    return MediaQuery.removePadding(
        context: context, removeTop: true, child: MyCustomerPage(me: me));

    // return MediaQuery.removePadding(
    //   context: context,
    //   removeTop: true,
    //   child: ListView(
    //     controller: sc,
    //     children: <Widget>[
    //       SizedBox(
    //         height: 12.0,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Container(
    //             width: 30,
    //             height: 5,
    //             decoration: BoxDecoration(
    //                 color: Colors.grey[300],
    //                 borderRadius: BorderRadius.all(Radius.circular(12.0))),
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 18.0,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text(
    //             "Explore Pittsburgh",
    //             style: TextStyle(
    //               fontWeight: FontWeight.normal,
    //               fontSize: 24.0,
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 36.0,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       ),
    //       SizedBox(
    //         height: 36.0,
    //       ),
    //       Container(
    //         padding: const EdgeInsets.only(left: 24.0, right: 24.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text("Images",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.w600,
    //                 )),
    //             SizedBox(
    //               height: 12.0,
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: 36.0,
    //       ),
    //       Container(
    //         padding: const EdgeInsets.only(left: 24.0, right: 24.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text("About",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.w600,
    //                 )),
    //             SizedBox(
    //               height: 12.0,
    //             ),
    //             Text(
    //               """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
    //               """,
    //               softWrap: true,
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: 24,
    //       ),
    //     ],
    //   ),
    // );
  }
}
