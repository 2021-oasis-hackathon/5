import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Googlemap_home extends StatefulWidget {
  const Googlemap_home({Key? key}) : super(key: key);

  @override
  _Googlemap_homeState createState() => _Googlemap_homeState();
}

class _Googlemap_homeState extends State<Googlemap_home> {
  List<Marker> _markers = [];
  late BitmapDescriptor icon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'imgs/logo1.png')
        .then((value) => icon = value);
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
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onCameraMove: (_) {},
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController sc) {
            setState(() {
              // _markers.add(Marker(
              //     markerId: MarkerId('Google'),
              //     draggable: false,
              //     icon: icon,
              //     position: LatLng(37.4537251, 126.7960716)));
            });
          },
          markers: Set.from(_markers),
        ),
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
