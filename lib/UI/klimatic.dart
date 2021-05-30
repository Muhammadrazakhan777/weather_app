import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  void showStuff() async {
    Map data = await getWeather(utils.appId, utils.defualt_city);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Climate',
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0, 10.9, 20.8, 0),
            child: Text(
              'Karachi',
              style: city_style(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: updateTempWidget('karachi'),
          ),
        ],
      ),
    );
  }

  TextStyle city_style() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 50,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle tempStyle() {
    return TextStyle(
      color: Colors.pink,
      fontStyle: FontStyle.normal,
      fontSize: 50,
      fontWeight: FontWeight.w900,
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=karachi&appid=529b42eaef4dcfe1523bcf7b6f18e1c9&units=metric';

    http.Response response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(utils.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          //here we get all data from json and setup widgets
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(50),
                  ),
                  ListTile(
                    leading: Text(
                      'Actual Temperature',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.pink,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        content["main"]["temp"].toString() + '\u00B0' + 'C',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Feels like',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.pink,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        content["main"]["feels_like"].toString() +
                            '\u00B0' +
                            'C',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Humidity',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.pink,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        content["main"]["humidity"].toString() + '\u00B0' + 'C',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Wind Speed',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.pink,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        content["wind"]["speed"].toString() + 'Km/h',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
