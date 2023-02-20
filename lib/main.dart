import 'package:flutter/material.dart';
import 'package:socialmedia_sparks/login.dart';
import 'package:socialmedia_sparks/routesGenerator.dart';


void main() {
  runApp( MaterialApp(
      navigatorKey: rootNav_key,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
      }
  ));

}



