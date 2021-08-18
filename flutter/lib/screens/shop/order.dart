import 'package:flutter/material.dart';
import 'package:qount/accounts/login.dart';

void main() => runApp(order_home());

class order_home extends StatelessWidget {
  const order_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: order());
  }
}

class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);

  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  String here_or_togo = 'here';
  int id = 1;
  int count = 0;
  bool _is_switched = false;
  int billing = 1;
  String pay = "mobile";

  void _add() {
    setState(() {
      count++;
    });
  }

  void _minus() {
    setState(() {
      if (count == 0) {
        return;
      }
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주문하기'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      here_or_togo = 'here';
                      id = 1;
                    });
                  }),
              Text('매장'),
              SizedBox(
                width: 130,
              ),
              Radio(
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      here_or_togo = 'togo';
                      id = 2;
                    });
                  }),
              Text('포장')
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //주문 리스트 위젯
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30,),
                      Text('test_menu1',style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 30,),
                      Text('test_price1',style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(

                    mini: true,
                    onPressed: _minus,
                    child: Icon(Icons.subdirectory_arrow_left),
                    backgroundColor: Color(0xff87dfb3),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '$count',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    onPressed: _add,
                    child: Icon(Icons.add),
                    mini: true,
                    backgroundColor: Color(0xff87dfb3),
                  )
                ],
              )

            ],
          ),


          //주문하기 구분선...
          Divider(
            height: 100, //위치조절
            thickness: 2, //두께조절
          ),

          //나머지 부가 수단
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('안심번호 사용'),
              SizedBox(
                width: 150,
              ),
              Switch(
                value: _is_switched,
                onChanged: (value) {
                  setState(() {
                    _is_switched = value;
                  });
                },
                activeColor: Color(0xff87dfb3),
              )
            ],
          ),
          //결제수단 선택
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('결제수단'),
              SizedBox(
                width: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                      value: 3,
                      groupValue: billing,
                      onChanged: (val) {
                        setState(() {
                          pay = 'mobile';
                          billing = 3;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Radio(
                      value: 4,
                      groupValue: billing,
                      onChanged: (val) {
                        setState(() {
                          pay = 'card';
                          billing = 4;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Radio(
                      value: 5,
                      groupValue: billing,
                      onChanged: (val) {
                        setState(() {
                          pay = 'cash';
                          billing = 5;
                        });
                      })
                ],
              )

            ],
          ),
          SizedBox(height: 15,),
          //총 구문 금액
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 30,),
                  Text('총 주문 금액',style: TextStyle(fontSize: 15),)
                ],


              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('20000000원',
                  style: TextStyle(fontSize: 15),),
                  SizedBox(width: 45,)
                ],
              )

            ],
          ),

          //결제하기 버튼
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonHeight: 20.0,

          )

          

         
        ],
      ),
    );
  }
}
