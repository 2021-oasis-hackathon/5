import 'package:flutter/material.dart';

Widget divide({
  required EdgeInsets margin,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
    ),
    margin: margin,
  );
}
