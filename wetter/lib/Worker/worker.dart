// class - different, method-specific
// instance - different data;
import 'dart:convert';
import 'package:http/http.dart' as http;

class worker
{
  late String location;

  // Constructor
  worker({required this.location}){
    location = this.location;
  }


  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  // method

 Future<void> getData() async
  {
    try{
      var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=5209b8f1046a62449ff976f00ad7f0a3'));
      Map data = jsonDecode(response.body);

      // Getting Temperature, Humidity, Air Speed;
      Map temp_data = data['main'];
      String gethumidity_data = temp_data['humidity'].toString();
      double gettemp = (temp_data['temp'] - 273.15);

      //Getting Descriptions;
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];



      //Getting Air Speed
      Map wind = data['wind'];
      double getwind_speed = wind['speed']/0.27777777777778;


      //Assigning Values;
      temp = gettemp.toStringAsFixed(2); // Degree Celsius
      humidity = gethumidity_data; // % Percentage
      air_speed = getwind_speed.toStringAsFixed(2); // Km/Hr
      description = getdesc;
      main = getmain_des;
      icon = weather_main_data['icon'].toString();
    }
    catch(e){
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";
    }

  }

}

