import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(login_home());

class login_home extends StatelessWidget {
  const login_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: login(),
    );
  }
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'imgs/logo.png',
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(

                      border: OutlineInputBorder(),
                      labelText: 'ID',
                    )),
                flex: 1,
              )

            ],
          )
        ],
      ),
    );
  }
}
