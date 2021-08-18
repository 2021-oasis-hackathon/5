import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qount/main.dart';
import 'package:qount/models/menu.dart';
import 'package:qount/models/shop.dart';
import 'package:http/http.dart' as http;
import 'package:qount/models/user.dart';
import 'package:qount/utils/display.dart';

class MenuGridView extends StatefulWidget {
  final UserMe me;
  final Shop shop;

  MenuGridView({required this.me, required this.shop});
  @override
  State<StatefulWidget> createState() {
    return MenuGridViewState(me, shop);
  }
}

class MenuGridViewState extends State<MenuGridView> {
  late Future<List<Menu>> menus;
  late Future<List<Menu>> menusRecommend;
  final UserMe me;
  final Shop shop;

  MenuGridViewState(this.me, this.shop);

  @override
  void initState() {
    super.initState();
    menus = fetchMenus();
    menusRecommend = fetchMenusRecommend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${shop.name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("${shop.openTime}", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("추천메뉴"),
              children: [
                Container(
                  height: 200,
                  child: FutureBuilder<List<Menu>>(
                    future: menusRecommend,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return snapshot.data![index]
                                  .toWidgetRecommend(context);
                              //return Card(child: Center(child: Text("dfdf")));
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error - SnapGridViewState");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text("메뉴"),
              children: [
                Container(
                  child: FutureBuilder<List<Menu>>(
                    future: menus,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          // gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 1,
                          //   crossAxisSpacing: 5.0,
                          //   mainAxisSpacing: 5.0,
                          //   childAspectRatio:
                          //       MediaQuery.of(context).size.width /
                          //           (MediaQuery.of(context).size.height / 7),
                          // ),
                          itemBuilder: (context, index) {
                            return snapshot.data![index]
                                .toWidgetListItem(context);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error - SnapGridViewState");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Menu>> fetchMenus() async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/shops/${shop.id}/menus"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${this.me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      Iterable list = json.decode(res.body);
      var menus = list.map((menu) => Menu.fromJson(menu)).toList();

      return menus;
    } else {
      displayDialog(
          context, "An Error Occurred", "메뉴 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("메뉴 목록을 불러오는 도중에 오류가 발생했습니다.");
  }

  Future<List<Menu>> fetchMenusRecommend() async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/shops/${shop.id}/menus"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${this.me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      Iterable list = json.decode(res.body);
      var menus = list
          .map((menu) => Menu.fromJson(menu))
          .where((it) => (it.recommend))
          .toList();
      // var menus = list
      //     .map((menu) => (menu["recommend"]) Menu.fromJson(menu) )
      //     .toList();

      return menus;
    } else {
      displayDialog(
          context, "An Error Occurred", "메뉴 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("메뉴 목록을 불러오는 도중에 오류가 발생했습니다.");
  }
}
