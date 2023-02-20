import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:socialmedia_sparks/login.dart';
import 'package:socialmedia_sparks/profilepage.dart';
GlobalKey<NavigatorState> rootNav_key = GlobalKey();
GlobalKey<NavigatorState> profile_key = GlobalKey();

class RouteGenerator {
  // This is the Breed/Adopt routesGenerator
  static Route<dynamic> generateRoute_Profile(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    //for each case called, checks are applied to navigation to the correct next page
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
        case '/profile_page':
          if (args is List) {
            return MaterialPageRoute(builder: (_) =>
                ProfilePage(
                    name: args![0], email: args[1], profilePicture: args[2]));
          }
          return _errorRoute();


      default:
      // if an unmatched route is called, return error route
        return _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ), // AppBar
        body: Center(
          child: Text('ERROR'),
        ), // Center
      ); // Scaffold
    }); // Material PageRoute
  }
}
