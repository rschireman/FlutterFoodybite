import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/restaurants.dart';
import 'dart:math';
import 'home.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

randomNum() {
  int randomNumber = new Random().nextInt(8);
  return randomNumber;
}

buildYelpRestaurantList() async {
  int num = randomNum();
  print("Random numer: " + num.toString());
  Directory tempdir = await getTemporaryDirectory();
  String tempdirPath = tempdir.path;
  var filecontents =
      await File('$tempdirPath/restaurant_data.txt').readAsString();

  var decodedData = jsonDecode(filecontents);
  print(decodedData[0]);
  print(decodedData.runtimeType);

  return decodedData;
}

class ResultsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Results"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Align(
            alignment: Alignment.center,
            child: Column(children: [
              Text("$num"),
              SizedBox(
                height: 20.0,
              ),
              Text("num"),
              RaisedButton(
                  child: Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]),
          ),
        ]));
  }
}
