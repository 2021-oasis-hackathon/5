import 'dart:convert';

import 'package:qount/main.dart';
import 'package:qount/models/shop.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/menu/menu_qr.dart';
import 'package:qount/utils/display.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class qr_home extends StatelessWidget {
  final UserMe me;
  const qr_home({required this.me});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: qr_reading(me: me));
  }
}

class qr_reading extends StatefulWidget {
  final UserMe me;
  const qr_reading({required this.me});

  @override
  _qr_readingState createState() => _qr_readingState(me: me);
}

class _qr_readingState extends State<qr_reading> {
  late Shop shop;
  final UserMe me;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  _qr_readingState({required this.me});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Scan Qr code of the shop",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Expanded(
              child: _buildQrView(context),
              flex: 3,
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    else
                      Text('Scan a code'),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(controller, context),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> _onQRViewCreated(
      QRViewController controller, BuildContext context) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData;
        shop = await fetchShop(result!.code);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            // builder: (context) => ShopGridView(me: user)));
            //builder: (context) => ShopGridView(me: user)));
            builder: (context) => MenuGridView(me: me, shop: shop)));
      });
    });
  }

  Future<Shop> fetchShop(String code) async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/shops/$code"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${this.me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      return Shop.fromJson(json.decode(res.body));
    } else {
      displayDialog(
          context, "An Error Occurred", "상점 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("상점 목록을 불러오는 도중에 오류가 발생했습니다.");
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
