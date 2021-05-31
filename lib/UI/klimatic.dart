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
      backgroundColor: Color.fromRGBO(0, 130, 141, 1),
      body: Stack(
        children: [
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
      color: Color.fromRGBO(0, 130, 141, 1),
      fontSize: 50,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle tempStyle() {
    return TextStyle(
      color: Color.fromRGBO(0, 130, 141, 1),
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
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin, size: 70, color: Colors.white),
                    Text(
                      'Karachi',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                'Actual Temp',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  content["main"]["temp"].toString() +
                                      '\u00B0' +
                                      'C',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 130, 141, 1),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'Feels Like',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
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
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 130, 141, 1),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'Humidity',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  content["main"]["humidity"].toString() + '%',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 130, 141, 1),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'Wind Speed',
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  content["wind"]["speed"].toString() + 'Km/h',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 130, 141, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
