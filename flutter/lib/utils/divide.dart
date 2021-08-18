import 'package:flutter/material.dart';

Widget divide({required EdgeInsets margin, required Color color}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: color,
        ),
      ),
    ),
    margin: margin,
  );
}
