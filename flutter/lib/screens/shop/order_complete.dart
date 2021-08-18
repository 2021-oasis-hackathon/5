import 'package:flutter/material.dart';
import 'package:qount/backups/slidingup_panel_backup.dart';
import 'package:qount/models/user.dart';
//void main() => runApp(order_complete_home());

class order_complete_home extends StatelessWidget {
  UserMe me;
  order_complete_home({required this.me});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: order_complete(me:me),
    );
  }
}

class order_complete extends StatefulWidget {
  UserMe me;
  order_complete({required this.me});

  @override
  _order_completeState createState() => _order_completeState(me:me);
}

class _order_completeState extends State<order_complete> {
  UserMe me;
  _order_completeState({required this.me});
  String _shop_name = 'name';
  int _order_number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('주문완료'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: MediaQuery.removePadding(
            context: context,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_shop_name',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text('주문이 정상적으로 완료되었습니다.',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        '주문번호: $_order_number',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder())),
                          child: Text('주문내역 상세')),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>sliding_home(me: me)));
                    },
                     style: ElevatedButton.styleFrom(
                       primary: Color(0xff74dfb3),
                       minimumSize: Size(double.infinity, 30)
                     ),
                    child: Text('확인'),
                  )
                    
                  ),

              ],
            )
    )
    );
  }
}
