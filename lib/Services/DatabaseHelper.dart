import 'dart:collection';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_barber/Models/Barber.dart';
import 'package:my_barber/Models/HelperModels/ReservationHelper.dart';
import 'package:my_barber/Models/Reservation.dart';
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

  Future<Barber> getSpecificBarber(String barber_id) async {
    Barber barber;
    try {
      await _databaseRef
          .child("barbers")
          .child(barber_id)
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var DATA = snapshot.value;
          barber = Barber.fromJson(DATA);
        } else {
          print(
              "DatabaseHelper - getSpecificBarber(): Error: snapshot is null");
        }
      });
    } catch (e) {
      print("DatabaseHelper - getSpecificBarber(): Error: ${e}");
    }
    print(barber);
    return barber;
  }

  Future<void> createReservation(
      String user_id, Reservation reservation) async {
    try {
      await _databaseRef
          .child("reservations")
          .child(user_id)
          .child(reservation.reservation_id)
          .set(reservation.toJson());
      await updateBookingCounter(reservation);
    } catch (e) {
      print("DatabaseHelper - createReservation(): Error: ${e}");
    }
  }

  Future<void> updateBookingCounter(Reservation reservation) async {
    try {
      await _databaseRef
          .child("booking")
          .child(reservation.berber_id)
          .child(reservation.date)
          .child(reservation.time.substring(0, 2))
          .once()
          .then((DataSnapshot snapshot) async {
        int counter = snapshot.value['counter'];
        counter++;
        await _databaseRef
            .child("booking")
            .child(reservation.berber_id)
            .child(reservation.date)
            .child(reservation.time.substring(0, 2))
            .set({'counter': counter});
        print("updateBookingCounter: " +
            snapshot.value.toString() +
            " counter: " +
            counter.toString());
      });
    } catch (e) {
      print("DatabaseHelper - updateBookingCounter(): Error: ${e}");
    }
  }

  Future<Map<int, int>> getCountersOfSpecificBarber(
      String barber_id, String time) async {
    SplayTreeMap<int, int> counters = SplayTreeMap<int, int>();
    try {
      await _databaseRef
          .child("booking")
          .child(barber_id)
          .child(time)
          .orderByValue()
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var DATA = snapshot.value;
          for (var individualKey in snapshot.value.keys) {
            print(
                "DatabaseHelper - getCountersOfSpecificBarber(): $individualKey");
            int counter = DATA[individualKey]['counter'];
            counters[int.parse(individualKey.toString())] = counter;
            //print("DatabaseHelper - getCountersOfSpecificBarber(): $counter");
          }
        } else {
          print(
              "DatabaseHelper - getCountersOfSpecificBarber(): Error: snapshot is null");
        }
      });
    } catch (e) {
      print("DatabaseHelper - getBarbers(): Error: ${e}");
    }
    print(counters);
    return counters;
  }

  Future<List<ReservationHelper>> getReservations(String user_id) async {
    List<ReservationHelper> reservations = [];
    try {
      await _databaseRef
          .child("reservations")
          .child(user_id)
          .once()
          .then((DataSnapshot snapshot) async {
        if (snapshot.value != null) {
          var DATA = snapshot.value;
          for (var individualKey in snapshot.value.keys) {
            Reservation reservation = Reservation.fromJson(DATA[individualKey]);
            Barber barber = await getSpecificBarber(reservation.berber_id);

            ReservationHelper reservationHelper = ReservationHelper(
                reservation.reservation_id,
                barber,
                reservation.date,
                reservation.time,
                reservation.service);
            reservations.add(reservationHelper);
          }
        } else {
          print("DatabaseHelper - getReservations(): Error: snapshot is null");
        }
      });
    } catch (e) {
      print("DatabaseHelper - getReservations(): Error: ${e}");
    }
    print(reservations);
    return reservations;
  }

  double findDistance(double firstLatitude, double firstLongitude,
      double secondLatitude, double secondLongitude) {
    return (sqrt(pow(firstLatitude - secondLatitude, 2) +
            pow(firstLongitude - secondLongitude, 2))) *
        100;
  }
}
