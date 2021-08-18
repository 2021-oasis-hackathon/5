import 'package:flutter/material.dart';
import 'package:qount/models/shop.dart';

MaterialColor checkCustomerCount(Shop shop) {
  if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() >= 0.75)
    return Colors.red;
  else if (shop.customerCount.toDouble() / shop.customerCountMax.toDouble() >=
      0.4) return Colors.yellow;
  return Colors.green;
}
