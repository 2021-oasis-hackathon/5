import 'package:flutter/material.dart';
import 'package:qount/main.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';

void main() => runApp(test());

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OrderPage());
  }
}

class OrderPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return OrderPage();
  }

  @override
  // TODO: implement icon
  Image get icon => Image.asset(
        "imgs/icon1.png",
        height: 50,
      );
  @override
  // TODO: implement label
  String get label => "마이페이지";
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
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          _build_listview_item()
        ],
      ),
    );
  }

  Widget _build_listview_item() {
    String _order_name = "Orders";
    int _order_number = 100;
    int _pay_number = 100;

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
                Text("$_order_name")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text("주문번호: $_order_number"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('가격: $_pay_number')
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
}
