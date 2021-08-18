import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:qount/screens/host/base.dart';
import 'package:qount/utils/divide.dart';

class MyCustomerPage extends StatefulWidget {
  UserMe me;
  MyCustomerPage({required this.me});
  @override
  State<StatefulWidget> createState() {
    return _State(me: me);
  }
}

class _State extends State<MyCustomerPage> {
  UserMe me;
  _State({required this.me});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "마이페이지",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "imgs/profile.jpg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "ID: ${me.email}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "닉네임: ${me.name}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "프로필 편집",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            divide(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.grey[200]!),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "주문내역",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            divide(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 80),
              color: Colors.black,
            ),
            Container(
              height: 50,
              child: TextButton(
                onPressed: () {},
                child: Text("공지사항", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 40,
              child: TextButton(
                onPressed: () {},
                child: Text("자주 묻는 질문", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 40,
              child: TextButton(
                onPressed: () {},
                child: Text("1:1 문의", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 54,
              child: TextButton(
                onPressed: () {},
                child: Text("푸시알람설정", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 40,
              child: TextButton(
                onPressed: () {},
                child: Text("버전정보", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
