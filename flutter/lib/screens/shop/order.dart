import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qount/accounts/login.dart';
import 'package:qount/models/shop.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/shop/order_complete.dart';

import '../../main.dart';

//void main() => runApp(order_home());

class order_home extends StatelessWidget {
  UserMe me;
  Shop shop;
  order_home({required this.me, required this.shop});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: order(me: me, shop: shop));
  }
}

class order extends StatefulWidget {
  UserMe me;
  Shop shop;
  order({required this.me, required this.shop});

  @override
  _orderState createState() => _orderState(me: me, shop: shop);
}

class _orderState extends State<order> {
  UserMe me;
  Shop shop;
  _orderState({required this.me, required this.shop});
  bool here_pressed = false;
  bool togo_pressed = false;
  String here_or_togo = 'here';
  int count = 0;
  List<int> counts = [];
  bool _is_switched = false;

  bool mobile = false;
  bool card = false;
  bool cash = false;
  int total_price = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      total_price = 0;
      here_pressed = false;
      togo_pressed = false;
      mobile = card = cash = false;
      for (Cart cart in me.Carts) {
        total_price += cart.price;
      }
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

    void _mobile_pressed() {
      setState(() {
        if (!mobile) {
          mobile = true;
          card = cash = false;
        }
      });
    }

    void _card_pressed() {
      setState(() {
        if (!card) {
          card = true;
          mobile = cash = false;
        }
      });
    }

    void _cash_pressed() {
      setState(() {
        if (!cash) {
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
              for (Cart cart in me.Carts)
                _build_order_information(me.Carts.indexOf(cart), cart),
              SizedBox(
                height: 30,
              )

              //객체 생성 함수
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
                    '$total_price',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 45,
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 233),

          //결제하기 버튼
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                int status;
                int stop = 0;
                for (Cart cart in me.Carts) {
                  status = await postPayment(cart, me.id, shop.id);
                  if (status != 201) {
                    stop = 1;
                  }
                }
                if (stop == 0)
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => order_complete_home(me: me)));
              },
              child: Text('결제하기'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Color(0xff74dfb3)),
            ),
          )
        ],
      ),
    );
  }

  Future<int> postPayment(
    Cart cart,
    int customerId,
    int hostId,
  ) async {
    var res = await http.post(
      Uri.parse('$SERVER_IP/payments'),
      headers: {"Content-Type": "application/json"},
      body: cart.toJson(customerId, hostId),
    );
    return res.statusCode;
  }

  Widget _build_order_information(int index, Cart cart) {
    //total_price += cart.price * cart.count;

    void _add() {
      setState(() {
        cart.count++;
        total_price += cart.price;
      });
    }

    void _minus() {
      setState(() {
        cart.count--;
        total_price -= cart.price;
      });
    }

    return Container(
      child: Stack(
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
                    '${cart.menu}',
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
                  Text('${cart.price}', style: TextStyle(fontSize: 15)),
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
                    '${cart.count}',
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
      ),
    );
  }
}
