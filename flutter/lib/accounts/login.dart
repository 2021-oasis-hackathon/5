import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
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
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('imgs/logo.png')),
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
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  var email = _emailController.text;
                  var password = _passwordController.text;
                  var user = await attemptLogIn(email, password);
                  if (user.jwt != "") {
                    SchedulerBinding.instance!
                        .addPostFrameCallback((timeStamp) {
                      // user as argumnet
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ShopGridView(me: user)));
                    });
                  } else {
                    displayDialog(context, "An Error Occurred",
                        "No Account was found matching that username and password");
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUp()));
                },
                child: Text('New User? Create Account'))
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
      UserMe me = UserMe(jwt: json.decode(res.body)['auth_token']);
      return me;
    }
    UserMe me = UserMe(jwt: "");
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