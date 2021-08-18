import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qount/main.dart';
import 'package:qount/models/payment.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';
import 'package:http/http.dart' as http;
import 'package:qount/utils/display.dart';

//void main() => runApp(test());

// class test extends StatelessWidget {
//   const test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: OrderPage());
//   }
// }

class OrderPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return OrderPage(me: me);
  }

  @override
  // TODO: implement icon
  Image get icon => Image.asset(
        "imgs/icon1.png",
        height: 50,
      );
  @override
  // TODO: implement label
  String get label => "주문현황";
}

class OrderPage extends StatefulWidget {
  UserMe me;
  OrderPage({required this.me});
  @override
  State<StatefulWidget> createState() {
    return _State(me: me);
  }
}

class _State extends State<OrderPage> {
  UserMe me;
  late Future<List<Payment>> payments;

  _State({required this.me});

  @override
  void initState() {
    super.initState();
    payments = fetchShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주문현황"),
      ),
      body: Container(
        child: FutureBuilder<List<Payment>>(
          future: payments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _build_listview_item(snapshot.data![index].name,
                      snapshot.data![index].id, snapshot.data![index].price);
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

  Widget _build_listview_item(
    String orderName,
    int orderId,
    int price,
  ) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text("$orderName")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text("주문번호: $orderId"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('가격: $price')
              ],
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: const Text("완료"),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        )
      ],
    );
  }

  Future<List<Payment>> fetchShops() async {
    var res = await http.get(
      Uri.parse("$SERVER_IP/payments"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${me.jwt}"
      },
    );
    if (res.statusCode == 200) {
      Iterable list = json.decode(res.body);
      List<Payment> payments =
          list.map((pay) => Payment.fromJson(pay)).toList();
      return payments;
    } else {
      displayDialog(
          context, "An Error Occurred", "결제 목록을 불러오는 도중에 오류가 발생했습니다.");
    }
    throw Exception("결제 목록을 불러오는 도중에 오류가 발생했습니다.");
  }
}
