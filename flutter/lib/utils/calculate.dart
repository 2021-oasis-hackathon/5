import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qount/models/shop.dart';

MaterialColor checkCustomerCount(Shop shop) {
  if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() >= 0.75)
    return Colors.red;
  else if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() >=
      0.4) return Colors.yellow;
  return Colors.green;
}

BitmapDescriptor checkCustomerCountMarker(Shop shop) {
  double hue = 0;
  if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() >= 1)
    hue = 1;
  else if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() <=
      0) hue = 0;
  return BitmapDescriptor.defaultMarkerWithHue(((1 - hue) * 120));
}
