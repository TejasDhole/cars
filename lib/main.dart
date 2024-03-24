import 'package:flutter/material.dart';
import 'package:cars/dashboard.dart'; // Import your Dashboard screen here
import 'package:cars/provider.dart';
import 'package:cars/rider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cars App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define your routes here
      routes: {
        '/': (context) => Dashborad(), // Set the initial route to your dashboard
        // '/provider': (context) => ProviderScreen(), // Define a route for the Provider screen
        // '/rider': (context) => rider(), // Define a route for the Rider screen
      },
      // You can optionally define a function to handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
      },
    );
  }
}
