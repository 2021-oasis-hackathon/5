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
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '마이페이지',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
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
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ID: ${me.email}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "닉네임: ${me.name}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "프로필 편집",
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                ),
                Divider(
                  height: 50,
                  color: Colors.grey[200]!,
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "주문내역",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 50,
                  color: Colors.black,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 50,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("공지사항", style: TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("자주 묻는 질문", style: TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("1:1 문의", style: TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 54,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("푸시알람설정", style: TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: 40,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("버전정보", style: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
