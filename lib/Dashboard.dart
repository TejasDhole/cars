import 'package:flutter/material.dart';
import 'package:cars/provider.dart';
import 'package:cars/rider.dart';

class Dashborad extends StatefulWidget {
  const Dashborad({Key? key}) : super(key: key);

  @override
  _DashboradState createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cars"),
        backgroundColor: Colors.blue, // Change to a predefined color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const rider()),
                    );
                    // Add Rider button onPressed code here!
                    print('Rider button pressed');
                  },
                  icon: const Icon(Icons.directions_bike),
                  label: const Text('Rider'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProviderScreen()),
                    );
                    // Add Provider button onPressed code here!
                    print('Provider button pressed');
                  },
                  icon: const Icon(Icons.local_shipping),
                  label: const Text('Provider'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
