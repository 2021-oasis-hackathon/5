import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qount/main.dart';
import 'package:qount/models/shop.dart';
import 'package:http/http.dart' as http;
import 'package:qount/models/user.dart';
import 'package:qount/utils/display.dart';

class ShopGridView extends StatefulWidget {
  final UserMe me;
  const ShopGridView({required this.me});

  @override
  State<StatefulWidget> createState() {
    return ShopGridViewState(this.me);
  }
}

class ShopGridViewState extends State<ShopGridView> {
  late Future<List<Shop>> shops;
  final UserMe me;

  ShopGridViewState(this.me);

  @override
  void initState() {
    super.initState();
    shops = fetchShops(this.me);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<Shop>>(
          future: shops,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.6),
                ),
                itemBuilder: (context, index) {
                  //return new Text("Sibal");
                  return snapshot.data![index].toWidgetGridTile();
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error - SnapGridViewState");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<Shop>> fetchShops(UserMe me) async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/shops"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${this.me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      Iterable list = json.decode(res.body);
      var shops = list.map((shop) => Shop.fromJson(shop)).toList();
      return shops;
    } else {
      displayDialog(
          context, "An Error Occurred", "상점 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("상점 목록을 불러오는 도중에 오류가 발생했습니다.");
  }
}
