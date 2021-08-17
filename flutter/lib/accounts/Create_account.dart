import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:qount/accounts/login.dart';
import 'package:qount/main.dart';
import 'package:qount/utils/display.dart';
import 'package:http/http.dart' as http;

class SignUp_home extends StatelessWidget {
  const SignUp_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '회원가입',
      home: SignUp(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isCheck = false;
  bool isCheck2 = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.fromLTRB(15, 70, 15, 0),
              child: TextField(
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디(이메일)',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 35, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                    hintText: 'Enter secure password'),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 35, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호 확인',
                    hintText: 'Enter secure password'),
                controller: _passwordConfirmationController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 35, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이름 (2-15글자)',
                    hintText: 'Enter secure password'),
                controller: _nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 35, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(height: 1),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '전화번호',
                    hintText: '010-0000-0000'),
                controller: _phoneNumberController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 15, right: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Checkbox(
                    value: isCheck,
                    onChanged: (value) {
                      setState(() {
                        isCheck = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "이용약관"),
                        TextSpan(text: ", "),
                        TextSpan(text: "개인정보취급방침"),
                        TextSpan(text: "을 확인하였고, 이에 동의합니다."),
                      ],
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 15, right: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Checkbox(
                    value: isCheck2,
                    onChanged: (value) {
                      setState(() {
                        isCheck2 = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "위치정보수집, 이용"),
                        TextSpan(text: "을 확인하였고, 이에 동의합니다."),
                      ],
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: FlatButton(
                onPressed: () async {
                  var email = _emailController.text;
                  var password = _passwordController.text;
                  var passwordConfirmation =
                      _passwordConfirmationController.text;
                  var name = _nameController.text;
                  var phoneNumber = _phoneNumberController.text;
                  var status = await attemptSignUp(email, password, name,
                      passwordConfirmation, "customer", phoneNumber);

                  if (!isCheck || !isCheck2) {
                    displayDialog(context, "An Error Occurred",
                        "이용 약관 및 정보 수집 여부에 동의해주세요.");
                  } else if (status == 201) {
                    SchedulerBinding.instance!
                        .addPostFrameCallback((timeStamp) async {
                      await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => new AlertDialog(
                          title: new Text("성공"),
                          content: new Text("회원 가입에 성공했습니다! 로그인을 해주세요."),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("로그인 화면을"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  } else {
                    displayDialog(context, "An Error Occurred",
                        "이미 사용 중인 이메일이거나, 생성할 수 없는 속성이 포함되어 있습니다. ");
                  }
                },
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> attemptSignUp(
    String email,
    String password,
    String name,
    String passwordConfirmation,
    String role,
    String phoneNumber,
  ) async {
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
            "nickname": "test"
          }
        },
      ),
    );
    return res.statusCode;
  }
}
