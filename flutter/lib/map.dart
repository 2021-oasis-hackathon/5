import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';


const String kakaoMapKey = '126e0dede332c2cfa302fbae9e177cf5';

class KakaoMapTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              KakaoMapView(
                  width: size.width,
                  height: size.height,
                  kakaoMapKey: kakaoMapKey,
                  lat: 35.227358,
                  lng: 126.841555,
                  showMapTypeControl: true,
                  showZoomControl: true,
                  markerImageURL:
                  'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                  onTapMarker: (message) async {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Marker is clicked')));

                    //await _openKakaoMapScreen(context);
                  }),

            ],
          ),
          FloatingSearchBar(
            transitionCurve: Curves.easeInOutCubic,
            transition: CircularFloatingSearchBarTransition(),
            physics: const BouncingScrollPhysics(),
            builder: (context, _) => buildBody(),
          ),
        ],
      )

    );
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



  // Future<void> _openKakaoMapScreen(BuildContext context) async {
  //   KakaoMapUtil util = KakaoMapUtil();
  //
  //   // String url = await util.getResolvedLink(
  //   //     util.getKakaoMapURL(37.402056, 127.108212, name: 'Kakao 본사'));
  //
  //   /// This is short form of the above comment
  //   String url =
  //   await util.getMapScreenURL(37.402056, 127.108212, name: 'Kakao 본사');
  //
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => KakaoMapScreen(url: url)));
  // }
}