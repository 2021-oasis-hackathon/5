import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class sliding_home extends StatelessWidget {
  const sliding_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sliding()
    );
  }
}

class sliding extends StatefulWidget {
  const sliding({Key? key}) : super(key: key);

  @override
  _slidingState createState() => _slidingState();
}

class _slidingState extends State<sliding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: Center(
          child: Text("This is the Widget behind the sliding panel"),
        ),
      ),
    );  }
}

