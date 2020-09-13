import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_foodybite/widgets/slide_item.dart';
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
        restaurant['location'],
        restaurant['rating']
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
      body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: randomYelpRestaurant(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SlideItem(
                    img: snapshot.data[1].toString(),
                    title: snapshot.data[0].toString(),
                    address: snapshot.data[2]['display_address']
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', ''),
                    rating: snapshot.data[3].toString());
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ])),
    );
  }
}
