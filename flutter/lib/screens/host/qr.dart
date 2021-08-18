import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qount/main.dart';
import 'package:qount/models/shop.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class QRPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return QRPage(me: me);
  }

  @override
  // TODO: implement icon
  Icon get icon => Icon(Icons.ac_unit);

  @override
  // TODO: implement label
  String get label => "QR발급";
}

class QRPage extends StatefulWidget {
  UserMe me;

  QRPage({required this.me});
  @override
  State<StatefulWidget> createState() {
    return _State(me: me);
  }
}

class _State extends State<QRPage> {
  UserMe me;

  _State({required this.me});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR 발급"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
            child: QrImage(
          data: "${me.shopId}",
          version: QrVersions.auto,
          size: 200.0,
        )),
      ),
    );
  }
}
