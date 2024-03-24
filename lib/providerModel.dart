import 'package:flutter/material.dart';

class RideDetails {
  String? startingPoint;
  String? destination;
  DateTime? departureDate;
  TimeOfDay? departureTime;
  int? numberOfSeats;
  String? carType;
  double? price;
  String? messageForPassenger;

  RideDetails({
     this.startingPoint,
     this.destination,
     this.departureDate,
     this.departureTime,
     this.numberOfSeats,
     this.carType,
     this.price,
     this.messageForPassenger,
  });
}
