import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/restaurants.dart';
import 'dart:math';
import '../util/YelpAPI.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

randomNum() {
  int randomNumber = new Random().nextInt(8);
  return randomNumber;
}

randomYelpRestaurant() async {
  int num = randomNum();
  Directory tempdir = await getTemporaryDirectory();
  String tempdirPath = tempdir.path;
  print(tempdirPath);
  var restarauntData = File('$tempdirPath/restaurant_data.txt');
  Map data = {};
  var listofRestaurants = await getListofRestaurants(baseurl, radius);

  Map<String, dynamic> decodedList = await jsonDecode(listofRestaurants);

  var strippedList = decodedList['businesses'];

  var indexRange = Iterable<int>.generate(strippedList.length).toList();

  for (int index = 0; index < indexRange.length;) {
    for (var restaurant in strippedList) {
      data[index] = [
        restaurant['name'],
        restaurant['image_url'],
        restaurant['location']
      ];
      index += 1;
    }
  }
  var finaldata = await data[num];
  print(finaldata);
  String encodedData = jsonEncode(data.toString());
  restarauntData.writeAsString(encodedData);

  return finaldata;
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
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: randomYelpRestaurant(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.toString());
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
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
