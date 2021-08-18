import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';

class OrderPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return OrderPage();
  }

  @override
  // TODO: implement icon
  Icon get icon => Icon(Icons.ac_unit);

  @override
  // TODO: implement label
  String get label => "주문현황";
}

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주문현황"),
      ),
      body: Container(),
    );
  }
}
