import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qount/main.dart';
import 'package:qount/models/shop.dart';
import 'package:qount/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:qount/screens/menu/menu.dart';
import 'package:qount/utils/calculate.dart';
import 'package:qount/utils/display.dart';
import 'package:qount/utils/marker.dart';

class Googlemap_home extends StatefulWidget {
  UserMe me;
  Googlemap_home({required this.me});

  @override
  _Googlemap_homeState createState() => _Googlemap_homeState(me: me);
}

class _Googlemap_homeState extends State<Googlemap_home> {
  //BuildContext _myContext;
  Set<Marker> _markers = {};
  UserMe me;
  late BitmapDescriptor icon;
  _Googlemap_homeState({required this.me});
  late Future<List<Shop>> shops;
  late List<Shop> shops_present;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shops = fetchShops(me);
  }

  // void _onMapCreated(GoogleMapController controller) async {
  //   shops = await fetchShops(me);
  //   _markers.clear();

  //   for (final shop in shops) {
  //     setState(() {
  //       _markers.add(customMarker(context, shop, me));
  //       // _markers.add(Marker(
  //       //     markerId: MarkerId(dnn['Device']),
  //       //     position: LatLng(dnn["EventData"][0]["GPSPoint_lat"],
  //       //         dnn["EventData"][0]["GPSPoint_lon"]),
  //       //     // icon: mapMarker,
  //       //     infoWindow: InfoWindow(
  //       //         title: dnn['Device'],
  //       //         snippet: dnn["EventData"][0]['address'])));
  //     });
  //   }
  // }

//   Future<int> future = getFuture();
// future.then((value) => handleValue(value))
//       .catchError((error) => handleError(error));

  void _onMapCreated(GoogleMapController controller, BuildContext context) {
    setState(() {
      for (final Shop shop in shops_present) {
        _markers.add(Marker(
            markerId: MarkerId(shop.id.toString()),
            position: LatLng(shop.latitude, shop.longitude),
            icon: checkCustomerCountMarker(shop),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuGridView(me: me, shop: shop)),
                )));
      }
    });
  }

  Future<List<Shop>> fetchShops(UserMe me) async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/shops"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${this.me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      Iterable list = json.decode(res.body);
      var shops = list.map((shop) => Shop.fromJson(shop)).toList();
      return shops;
    } else {
      displayDialog(
          context, "An Error Occurred", "상점 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("상점 목록을 불러오는 도중에 오류가 발생했습니다.");
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.4537251, 126.7960716),
      zoom: 14.4746,
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder<List<Shop>>(
          future: shops,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              shops_present = snapshot.data!;
              return GoogleMap(
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onCameraMove: (_) {},
                myLocationButtonEnabled: false,
                onMapCreated: (controller) =>
                    _onMapCreated(controller, context),
                markers: Set.from(_markers),
              );
            } else if (snapshot.hasError) {}
            return CircularProgressIndicator();
          },
        ),
        // GoogleMap(
        //   mapToolbarEnabled: false,
        //   zoomControlsEnabled: false,
        //   mapType: MapType.normal,
        //   initialCameraPosition: _kGooglePlex,
        //   onCameraMove: (_) {},
        //   myLocationButtonEnabled: false,
        //   onMapCreated: _onMapCreated,
        //   markers: Set.from(_markers),
        // ),
        FloatingSearchBar(
          transitionCurve: Curves.easeInOutCubic,
          transition: CircularFloatingSearchBarTransition(),
          physics: const BouncingScrollPhysics(),
          builder: (context, _) => buildBody(),
        ),
      ],
    ));
  }

  Widget buildBody() {
    final time = DateTime.now();
    print('BuildBody at ${time.second}:${time.millisecond}');
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: Column(
          children: List.generate(100, (index) => index.toString())
              .map((e) => ListTile(
                    title: Text(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
