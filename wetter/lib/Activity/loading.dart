import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wetter/Worker/worker.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);


  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String city = 'Kolkata';
  late String temp;
  late String hum;
  late String air_speed;
  late String desc;
  late String main;
  late String icon;

  void startApp(String city) async
  {
    worker instance  = worker(location: city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    desc = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
      "temp_value" : temp,
      "hum_value" : hum,
      "air_speed_value" : air_speed,
      "desc_value": desc,
      "main_value" : main,
      "icon_value" : icon,
      "city_value" : city,
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;

    if(search?.isNotEmpty ?? false){
      city = search!['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80),
              Image.asset("assets/images/wetter.png", height: 120, width: 120,),
              SizedBox(height: 15,),
              Text("WETTER",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
              SizedBox(height: 8,),
              Text("By Tachyon",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),),
              SizedBox(height: 20,),
              SpinKitWave(
                color: Colors.black,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    );
  }
}
