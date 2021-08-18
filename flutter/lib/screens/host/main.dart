import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/host/base.dart';
import 'package:qount/screens/host/my.dart';
import 'package:qount/screens/host/order.dart';
import 'package:qount/screens/host/phone.dart';
import 'package:qount/screens/host/qr.dart';

class MainHostPage extends StatefulWidget {
  UserMe me;
  MainHostPage({required this.me});
  @override
  State<StatefulWidget> createState() => _State(me: me);
}

class _State extends State {
  final List<BasePageGenerator> _widgets = [
    OrderPageGenerator(),
    QRPageGenerator(),
    PhonePageGenerator(),
    MyPageGenerator(),
  ];

  UserMe me;

  _State({required this.me});

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_currentIndex].createWidget(
        me: me,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: _widgets.map((e) => e.toWidgetItem()).toList(),
        onTap: (e) => setState(() => _currentIndex = e),
      ),
    );
  }
}
