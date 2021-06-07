import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/Users.dart';
import 'dart:io';

import 'package:my_barber/Screens/Home/HomeScreen.dart';
import 'package:my_barber/Screens/Login/LoginScreen.dart';
import 'package:my_barber/Utils/app_localizations.dart';

class DatabaseHelper {
  final _databaseRef =
      FirebaseDatabase.instance.reference(); //database reference object

  Future<List<Barber>> getBarbers() async {
    List<Barber> barbers = [];
    try {
      await _databaseRef.child("barbers").once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var DATA = snapshot.value;
          for (var individualKey in snapshot.value.keys) {
            Barber barber = Barber.fromJson(DATA[individualKey]);
            barbers.add(barber);
          }
        } else {
          print("DatabaseHelper - getBarbers(): Error: snapshot is null");
        }
      });
    } catch (e) {
      print("DatabaseHelper - getBarbers(): Error: ${e}");
    }
    print(barbers);
    return barbers;
  }
}
