import 'package:flutter/material.dart';

import 'package:flutter_foodybite/util/categories.dart';
// import 'package:flutter_foodybite/util/restaurants.dart';
import 'package:flutter_foodybite/widgets/category_item.dart';
import 'package:flutter_foodybite/widgets/slide_item.dart';
import '../util/YelpAPI.dart';
import 'dart:convert';
import 'results_screen.dart';
import 'package:flutter_foodybite/main.dart';

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
    return FutureBuilder(
        future: getListofRestaurantsYelp(),
        builder: (BuildContext context, AsyncSnapshot futureRestaurantList) {
          if (futureRestaurantList.connectionState == ConnectionState.done) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: futureRestaurantList.data == null
                    ? 0
                    : futureRestaurantList.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Map restaurant = futureRestaurantList.data;

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: restaurant[index][1].toString(),
                      title: restaurant[index][0].toString(),
                      address: restaurant[index][2]['display_address']
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      rating: restaurant[index][3].toString(),
                    ),
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

getListofRestaurantsYelp() async {
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
  // print('Homepage data: ' + data.toString());

  return data;
}
