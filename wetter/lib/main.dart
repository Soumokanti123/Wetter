import 'package:flutter/material.dart';
import 'package:wetter/Activity/home.dart';
import 'package:wetter/Activity/loading.dart';
import 'package:wetter/Activity/location.dart';

void main(){
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const Loading(),
        '/home' : (context) => const Home(),
        "/loading" : (context) => const Loading(),
      },
    ),
  );
}