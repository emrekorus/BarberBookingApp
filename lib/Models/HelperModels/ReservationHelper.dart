import 'package:firebase_database/firebase_database.dart';
import 'package:my_barber/Models/Barber.dart';

class ReservationHelper {
  String reservation_id;
  Barber barber;
  String date;
  String time;
  String service;

  ReservationHelper.empty();

  ReservationHelper(
      this.reservation_id, this.barber, this.date, this.time, this.service);

  ReservationHelper.fromSnapshot(DataSnapshot snapshot) {
    reservation_id = snapshot.value['reservation_id'];
    barber = snapshot.value['barber'];
    date = snapshot.value['date'];
    time = snapshot.value['time'];
    service = snapshot.value['service'];
  }

  factory ReservationHelper.fromJson(dynamic json) {
    return ReservationHelper(
      json['reservation_id'] as String,
      json['barber'] as Barber,
      json['date'] as String,
      json['time'] as String,
      json['service'] as String,
    );
  }

  Map toJson() => {
        'reservation_id': reservation_id,
        'barber': barber,
        'date': date,
        'time': time,
        'service': service,
      };

  @override
  String toString() {
    return 'Reservation{reservation_id: $reservation_id, barber: $barber, date: $date, time: $time, service: $service}';
  }
}
