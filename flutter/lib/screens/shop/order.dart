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
  bool here_pressed = false;
  bool togo_pressed = false;
  String here_or_togo = 'here';
  int count = 0;
  List<int> counts = [];
  bool _is_switched = false;

  bool mobile = false;
  bool card = false;
  bool cash = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      here_pressed = false;
      togo_pressed = false;
      mobile = card = cash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _here_change_pressed() {
      setState(() {
        if (here_pressed) {
          return;
        } else {
          here_pressed = true;
          togo_pressed = false;
        }
      });
    }

    void _togo_change_pressed() {
      setState(() {
        if (togo_pressed) {
          return;
        } else {
          togo_pressed = true;
          here_pressed = false;
        }
      });
    }

    void _mobile_pressed(){
      setState(() {
        if (!mobile){
          mobile = true;
          card = cash = false;
        }
      });
    }
    void _card_pressed(){
      setState(() {
        if (!card){
          card = true;
          mobile = cash = false;
        }
      });
    }
    void _cash_pressed(){
      setState(() {
        if (!cash){
          cash = true;
          card = mobile = false;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('주문하기'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => _here_change_pressed(),
                  child: Text(
                    '매장',
                    style: here_pressed
                        ? TextStyle(color: Color(0xff74dfb3), fontSize: 20)
                        : TextStyle(color: Colors.grey, fontSize: 20),
                  )),
              SizedBox(
                width: 150,
              ),
              TextButton(
                  onPressed: () => _togo_change_pressed(),
                  child: Text(
                    '포장',
                    style: togo_pressed
                        ? TextStyle(color: Color(0xff74dfb3), fontSize: 20)
                        : TextStyle(color: Colors.grey, fontSize: 20),
                  )),
            ],
          ),

          SizedBox(
            height: 25,
          ),
          //주문 리스트 위젯
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _build_order_information(), //객체 생성 함수
              SizedBox(
                height: 30,
              ),
              _build_order_information(),

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
                width: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => _mobile_pressed(),
                      child: Text(
                        '모바일',
                        style: mobile
                            ? TextStyle(color: Color(0xff74dfb3), fontSize: 15)
                            : TextStyle(color: Colors.grey, fontSize: 15),
                      )),

                  TextButton(
                      onPressed: () => _card_pressed(),
                      child: Text(
                        '카드',
                        style: card
                            ? TextStyle(color: Color(0xff74dfb3), fontSize: 15)
                            : TextStyle(color: Colors.grey, fontSize: 15),
                      )),
                  TextButton(
                      onPressed: () => _cash_pressed(),
                      child: Text(
                        '현금',
                        style: cash
                            ? TextStyle(color: Color(0xff74dfb3), fontSize: 15)
                            : TextStyle(color: Colors.grey, fontSize: 15),
                      )),

                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          //총 구문 금액
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '총 주문 금액',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '20000000원',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 45,
                  )
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

  Widget _build_order_information() {
    int count = 0;
    counts.add(count);
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
                Text(
                  'test_menu1',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('test_price1', style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: FittedBox(
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: _minus,
                      child: Icon(Icons.subdirectory_arrow_left),
                      backgroundColor: Color(0xff87dfb3),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '$count',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: FittedBox(
                      child: FloatingActionButton(
                    onPressed: _add,
                    child: Icon(Icons.add),
                    mini: true,
                    backgroundColor: Color(0xff87dfb3),
                  )),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
