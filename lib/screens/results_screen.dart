import 'package:flutter/material.dart';
import '../util/restaurants.dart';
import 'dart:math';
import 'home.dart';

randomNum() {
  int randomNumber = new Random().nextInt(30);
  return randomNumber;
}

class ResultsRoute extends StatelessWidget {
  final int num = randomNum();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(children: [
          Text("$num"),
          RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              })
        ]),
      ),
    );
  }
}
