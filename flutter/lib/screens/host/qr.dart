import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';

class QRPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return QRPage();
  }

  @override
  // TODO: implement icon
  Icon get icon => Icon(Icons.ac_unit);

  @override
  // TODO: implement label
  String get label => "QR발급";
}

class QRPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR 발급"),
      ),
      body: Container(),
    );
  }
}
