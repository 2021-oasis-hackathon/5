import 'package:flutter/material.dart';

void main() => runApp(Mypage());

class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mypage_home(),
    );
  }
}

class Mypage_home extends StatefulWidget {
  const Mypage_home({Key? key}) : super(key: key);

  @override
  _Mypage_homeState createState() => _Mypage_homeState();
}

class _Mypage_homeState extends State<Mypage_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mypage'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Image.asset('imgs/profile.jpg'),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            width: 250,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 20,
                      ),
                      Text('프로필 수정')
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 20,
                      ),
                      Text('프로필 수정')
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
