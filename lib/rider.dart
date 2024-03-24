import 'dart:convert';

import 'package:cars/providerModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class rider extends StatefulWidget {
  const rider({Key? key}) : super(key: key);

  @override
  State<rider> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<rider> {
  // Variables to store user selections
  String _startingPoint = "";
  String _destination = "";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _noOfSeats = 1;
  bool _showAvailableRides = false;

  // Sample data for available rides (replace it with your actual data)
  List<RideDetails> availableRides = [];


  // Functions to handle user input changes
  void _onStartingPointChange(String value) {
    setState(() {
      _startingPoint = value;
    });
  }

  void _onDestinationChange(String value) {
    setState(() {
      _destination = value;
    });
  }

  void _handleDatePick(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleTimePick(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _incrementSeats() {
    setState(() {
      _noOfSeats++;
    });
  }

  void _decrementSeats(int currentSeats) {
    if (currentSeats > 1) {
      setState(() {
        _noOfSeats--;
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) _handleDatePick(picked);
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) _handleTimePick(picked);
  }


  void _searchRides() async {
    availableRides = getFakeRides();
    setState(() {
      _showAvailableRides = true;
    });
    // API endpoint URL
    // final apiUrl = 'YOUR_API_ENDPOINT_URL';
    //
    // // Prepare request body with user inputs
    // final requestBody = {
    //   'startingPoint': _startingPoint,
    //   'destination': _destination,
    //   'date': _selectedDate.toString(),
    //   'time': _selectedTime.toString(),
    //   'noOfSeats': _noOfSeats.toString(),
    // };
    //
    // // Make API call
    // var response = await http.post(
    //   Uri.parse(apiUrl),
    //   body: jsonEncode(requestBody),
    //   headers: {'Content-Type': 'application/json'},
    // );
    //
    // // Check if API call was successful
    // if (response.statusCode == 200) {
    //   // Parse the response body
    //   final responseData = jsonDecode(response.body);
    //
    //   // Extract available rides from the response data
    //   var availableRides = responseData['rides'];
    //
    //   setState(() {
    //     _showAvailableRides = true;
    //     availableRides = availableRides;
    //   });
    // } else {
    //   // Show error message if API call fails
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text('Error'),
    //       content: Text('Failed to fetch available rides. Please try again later.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Starting Point',
                border: OutlineInputBorder(),
              ),
              onChanged: _onStartingPointChange,
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(),
              ),
              onChanged: _onDestinationChange,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _selectedDate.toString().substring(0, 10),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    _selectedTime.format(context),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. of Seats: $_noOfSeats'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _decrementSeats(_noOfSeats),
                    ),
                    Text('$_noOfSeats'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _incrementSeats,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _searchRides,
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            if (_showAvailableRides)
              ...availableRides.map(
                    (ride) => Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              ride.startingPoint ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              ride.destination ?? 'N/A',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Departure Date: ${ride.departureDate?.toString().substring(0, 10) ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.calendar_today,
                              color: Colors.green,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Departure Time: ${ride.departureTime?.format(context) ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.access_time,
                              color: Colors.orange,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Number of Seats: ${ride.numberOfSeats ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.event_seat,
                              color: Colors.deepPurple,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Car Type: ${ride.carType ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.directions_car,
                              color: Colors.teal,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Price: ${ride.price ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.attach_money,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                            title: Text(
                              'Message for Passenger: ${ride.messageForPassenger ?? 'N/A'}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            leading: Icon(
                              Icons.message,
                              color: Colors.blueGrey,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )

              ),
          ],
        ),
      ),
    );
  }

  List<RideDetails> getFakeRides() {
    return [
      RideDetails(
        startingPoint: 'Starting Point 1',
        destination: 'Destination 1',
        departureDate: DateTime(2022, 12, 15),
        departureTime: TimeOfDay(hour: 8, minute: 30),
        numberOfSeats: 4,
        carType: 'Sedan',
        price: 50.0,
        messageForPassenger: 'Enjoy the ride!',
      ),
      RideDetails(
        startingPoint: 'Starting Point 2',
        destination: 'Destination 2',
        departureDate: DateTime(2022, 12, 20),
        departureTime: TimeOfDay(hour: 10, minute: 0),
        numberOfSeats: 2,
        carType: 'SUV',
        price: 70.0,
        messageForPassenger: 'Have a safe trip!',
      ),
      RideDetails(
        startingPoint: 'Starting Point 3',
        destination: 'Destination 3',
        departureDate: DateTime(2022, 12, 25),
        departureTime: TimeOfDay(hour: 12, minute: 15),
        numberOfSeats: 3,
        carType: 'Hatchback',
        price: 40.0,
        messageForPassenger: 'Happy travels!',
      ),
    ];
  }
}
