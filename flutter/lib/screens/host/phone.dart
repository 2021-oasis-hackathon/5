import 'package:flutter/material.dart';
import 'package:qount/models/user.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qount/screens/host/base.dart';

void main() => runApp(test());

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PhonePage());
  }
}

class PhonePageGenerator with BasePageGenerator {
  @override
  Widget createWidget({required UserMe me}) {
    return PhonePage();
  }

  @override
  // TODO: implement icon
  Icon get icon => Icon(Icons.ac_unit);

  @override
  // TODO: implement label
  String get label => "연락처 입력";
}

class PhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PhonePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("연락처 입력"),
      ),
      body: Column(
        children: [
          SizedBox(height: 200,),
          Text('번호를 입력한 뒤 확인 버튼을 눌러주세요'),
          SizedBox(height: 30,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone number',
            ),
            keyboardType: TextInputType.number,


          )
        ],
      ),
    );
  }
}
