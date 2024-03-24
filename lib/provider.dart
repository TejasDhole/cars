// provider_screen.dart
import 'package:cars/providerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _startingPointController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _noOfSeats = 1;
  String _carType = '';
  double _price = 0.0;
  String _message = '';

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create an instance of RideDetails with the form data
      RideDetails rideDetails = RideDetails(
        startingPoint: _startingPointController.text,
        destination: _destinationController.text,
        departureDate: _selectedDate,
        departureTime: _selectedTime,
        numberOfSeats: _noOfSeats,
        carType: _carType,
        price: _price,
        messageForPassenger: _message,
      );

      // Now you can perform any action you want with rideDetails,
      // like sending it to an API, storing it locally, etc.

      // Reset form after submission
      _formKey.currentState!.reset();

      // Show a confirmation message or navigate to another screen
      setState(() {
        _message = 'Ride published successfully!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Screen'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _startingPointController,
                decoration: InputDecoration(labelText: 'Starting Point'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter starting point';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destination'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      'Date: ${_selectedDate.toString().substring(0, 10)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text('Time: ${_selectedTime.format(context)}'),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of Seats'),
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _noOfSeats = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Car Type'),
                onChanged: (value) {
                  setState(() {
                    _carType = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _price = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Message for Passenger'),
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Publish Ride'),
              ),
              SizedBox(height: 10.0),
              if (_message.isNotEmpty)
                Text(
                  _message,
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
