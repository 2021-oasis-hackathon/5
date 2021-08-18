import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:qount/screens/home/map.dart';
import 'package:qount/screens/host/main.dart';
import 'package:qount/screens/shop/order.dart';
import 'package:qount/screens/shop/shop.dart';
import 'package:qount/utils/display.dart';
import '../main.dart';
import 'Create_account.dart';
import 'package:qount/examples/s_panel_example.dart';
import '../screens/home/slidingup_panel.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginHome(),
    );
  }
}

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginHome> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(

                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(
                  'imgs/logo.png',
                  width: 300,
                  height: 150,
                  fit: BoxFit.cover,
                )),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white10,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
                controller: _emailController,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
                controller: _passwordController,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 290,
              decoration: BoxDecoration(
                color: Color(0xff74dfb3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () async {
                  var email = _emailController.text;
                  var password = _passwordController.text;
                  var user = await attemptLogIn(email, password);
                  if (user.jwt != "") {
                    print("is ok?");
                    print("${user.role}");
                    // SchedulerBinding.instance!
                    //     .addPostFrameCallback((timeStamp) {
                    //   // user as argumnet
                    if (user.role == "host") {
                      print("host");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          // builder: (context) => ShopGridView(me: user)));
                          //builder: (context) => ShopGridView(me: user)));
                          builder: (context) => MainHostPage(me: user)));
                    } else if (user.role == "customer") {
                      print("cusotmer");
                      Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => ShopGridView(me: user)));
                          //builder: (context) => ShopGridView(me: user)));
                          builder: (context) => sliding(me: user)));
                          //builder: (context) => sliding_home(me: user)));

                    }

                    // });
                  } else {
                    displayDialog(context, "An Error Occurred",
                        "No Account was found matching that username and password");
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
            // SizedBox(
            //   height: 130,
            // ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUp()));
              },
              child: Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<UserMe> attemptLogIn(String email, String password) async {
    var res = await http.post(
      Uri.parse("$SERVER_IP/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'authentication': {
            "email": email,
            "password": password,
          }
        },
      ),
    );
    if (res.statusCode == 200) {
      var j = json.decode(res.body);

      UserMe me = UserMe(
        id: j['id'],
        jwt: j['auth_token'],
        email: j['email'],
        role: j['role'],
        phoneNumber: j['phone_number'],
        name: j['name'],
        shopId: j['shop_id'],
      );
      //me.email
      return me;
    }
    UserMe me = UserMe(
        jwt: "",
        id: 0,
        email: "",
        role: "",
        phoneNumber: "",
        name: "",
        shopId: 0);
    return me;
  }

  Future<int> attemptSignUp(
      String email,
      String password,
      String name,
      String passwordConfirmation,
      String role,
      String phoneNumber,
      String nickname) async {
    var res = await http.post(
      Uri.parse('$SERVER_IP/users'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "user": {
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "role": role,
            "phone_number": phoneNumber,
            "nickname": nickname
          }
        },
      ),
    );

    return res.statusCode;
  }
}
    // "user":{
    // "name":"kylee_customer",
    // "email": "email1@email.com",
    // "nickname": "나는밥버거",
    // "password": "pwd",
    // "password_confirmation": "pwd",
    // "role": "customer",
    // "phone_number": "010-1234-1234"
    // }