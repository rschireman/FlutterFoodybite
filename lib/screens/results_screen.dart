import 'package:flutter/material.dart';
import '../util/restaurants.dart';
import 'dart:math';

randomNum() {
  int randomNumber = new Random().nextInt(30);
  return randomNumber;
}

class ResultsRoute extends StatelessWidget {
  int num = randomNum();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: [Text("$num")],
      ),
    ));
  }
}
