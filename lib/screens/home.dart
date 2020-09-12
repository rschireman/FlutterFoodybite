import 'package:flutter/material.dart';
import 'package:flutter_foodybite/screens/trending.dart';
import 'package:flutter_foodybite/util/categories.dart';
import 'package:flutter_foodybite/util/restaurants.dart';
import 'package:flutter_foodybite/widgets/category_item.dart';
import 'package:flutter_foodybite/widgets/slide_item.dart';
import '../util/YelpAPI.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'results_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shake to Select"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildCategoryRow('Restaurants near you', context),
            SizedBox(height: 10.0),
            buildRestaurantList(context),
            SizedBox(height: 10.0),
            buildCategoryRow('Category', context),
            SizedBox(height: 10.0),
            buildCategoryList(context),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("TEST"),
                onPressed: () async {
                  Directory tempdir = await getTemporaryDirectory();
                  String tempdirPath = tempdir.path;
                  print(tempdirPath);
                  var restarauntData = File('$tempdirPath/restaurant_data.txt');
                  final Map data = {};

                  var listofRestaurants =
                      await getListofRestaurants(baseurl, radius);

                  Map<String, dynamic> decodedList =
                      await jsonDecode(listofRestaurants);

                  var strippedList = decodedList['businesses'];
                  print(strippedList.length.toString());
                  var indexRange =
                      Iterable<int>.generate(strippedList.length).toList();
                  print(indexRange);
                  for (int index = 0; index < indexRange.length;) {
                    for (var restaurant in strippedList) {
                      data[restaurant['name']] = [
                        index,
                        restaurant['image_url'],
                        restaurant['location']
                      ];
                      index += 1;
                    }
                  }
                  String encodedData = jsonEncode(data.toString());
                  restarauntData.writeAsString(encodedData.toString());
                  buildYelpRestaurantList();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsRoute(),
                      ));
                })
          ],
        ),
      ),
    );
  }

  buildCategoryRow(String category, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$category",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        IconButton(
          tooltip: 'Refresh',
          icon: Icon(Icons.refresh),
          onPressed: () {
            print("Refresh");
          },
        ),
      ],
    );
  }

  buildCategoryList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (BuildContext context, int index) {
          Map cat = categories[index];

          return CategoryItem(
            cat: cat,
          );
        },
      ),
    );
  }

  buildRestaurantList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: restaurants == null ? 0 : restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          Map restaurant = restaurants[index];

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SlideItem(
              img: restaurant["img"],
              title: restaurant["title"],
              address: restaurant["address"],
              rating: restaurant["rating"],
            ),
          );
        },
      ),
    );
  }
}
