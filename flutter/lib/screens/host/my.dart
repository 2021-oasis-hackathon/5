import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:qount/screens/host/base.dart';

class MyPageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return MyPage(me: me);
  }

  @override
  // TODO: implement icon
  Icon get icon => Icon(Icons.ac_unit);

  @override
  // TODO: implement label
  String get label => "마이페이지";
}

class MyPage extends StatefulWidget {
  UserMe me;
  MyPage({required this.me});
  @override
  State<StatefulWidget> createState() {
    return _State(me: me);
  }
}

class _State extends State<MyPage> {
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
                    children: [
                      Text(
                        "${me.name}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("프로필 편집"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("영업일시중지"),
              ],
            ),
            Row(
              children: [
                Text("가게관리"),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text("공지사항"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("자주 묻는 질문"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("1:1 문의"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("푸시알람설정"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("버전정보"),
            ),
          ],
        ),
      ),
    );
  }
}
