import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qount/models/shop.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/menu/menu.dart';
import 'package:qount/utils/calculate.dart';

Marker customMarker(BuildContext context, Shop shop, UserMe me) {
  return Marker(
    markerId: MarkerId(shop.id.toString()),
    position: LatLng(shop.latitude, shop.longitude),
    icon: checkCustomerCountMarker(shop),
    onTap: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          // builder: (context) => ShopGridView(me: user)));
          //builder: (context) => ShopGridView(me: user)));
          builder: (context) => MenuGridView(me: me, shop: shop)));
    },
  );
}
