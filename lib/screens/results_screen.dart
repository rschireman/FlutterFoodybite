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

  var decodedData = jsonDecode(filecontents);
  print(decodedData);
  // List yelpRestaurants =
}

class ResultsRoute extends StatelessWidget {
  int num = randomNum();
  List locations = restaurants;

  @override
  Widget build(BuildContext context) {
    Map result = restaurants[num];
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
              Text(result['title']),
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
