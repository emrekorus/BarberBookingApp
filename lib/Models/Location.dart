import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_barber/Models/Personels.dart';
import 'package:my_barber/Models/Review.dart';

class Location {
  Icon icon;
  double latitude;
  double longitude;
  String name;

  Location.empty();

  Location(this.icon, this.latitude, this.longitude, this.name);

  @override
  String toString() {
    return 'Location{icon: $icon, latitude: $latitude, longitude: $longitude, name: $name}';
  }
}
