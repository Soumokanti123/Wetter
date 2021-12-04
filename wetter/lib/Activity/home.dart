import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Async - Functions start But return some delayed

  // Future.delayed - Function start after some delayed

  // void getData() async
  // {
  //   // Get Data
  //  var response = await http.get(Uri.https('mytimeapi.herokuapp.com', 'time/Asia/Kolkata'));
  //  // print(response.body);
  //  // If we need a specific output from the json file, then we use "jsonDecode"
  //  Map data =  jsonDecode(response.body);
  //  print(data['time']);
  // }
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState(); // agge implement karne kliye

    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)!.settings.arguments as Map?;
    var city_name = [
      'Kolkata',
      'Delhi',
      'Mumbai',
      'Indore',
      'London',
      'Hyderabad'
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    String temp = (info!['temp_value']);
    String icon = (info['icon_value']);
    String _city = info['city_value'];
    String desc = (info['desc_value']);
    String humi = info['hum_value'];
    String air_speed = info['air_speed_value'];
    if(temp == 'NA' || air_speed == 'NA'){
      print("NA");
    }


    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(0),
        //   child: AppBar(
        //     backgroundColor: Colors.lightBlue,
        //   ),
        // ),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: NewGradientAppBar(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent.shade100,
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.lightBlueAccent.shade100,
                  Colors.blue.shade900,
                ],
              )),
              child: Column(
                children: <Widget>[
                  Container(
                    // Search Container
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((searchController.text).replaceAll(" ", "") == ""){
                              print("Blank search");
                            }
                            else{
                              Navigator.pushReplacementNamed(context, "/loading", arguments: {
                                "searchText" : searchController.text,
                              });
                            }

                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city ",
                            ),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Text("$desc",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("In $_city",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$temp",
                                  style: TextStyle(
                                    fontSize: 60,
                                  ),),
                                  Text("°C",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.day_light_wind),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text("$air_speed",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Km/Hr"),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text("$humi",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text("Percent"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Made By Tachyon",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Data provided By OpenWeathermap.org",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
