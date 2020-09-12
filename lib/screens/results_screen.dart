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
  Directory tempdir = await getTemporaryDirectory();
  String tempdirPath = tempdir.path;
  String filecontents =
      await File('$tempdirPath/restaurant_data.txt').readAsString();

  var decodedData = await jsonDecode(filecontents);

  return decodedData;
}

getRandomYelpRestaurant() async {
  var locations = await buildYelpRestaurantList();
}

class ResultsRoute extends StatelessWidget {
  int num = randomNum();
  var results = getRandomYelpRestaurant();
  @override
  Widget build(BuildContext context) {
    print(results);
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
