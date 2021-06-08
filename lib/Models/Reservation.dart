import 'package:firebase_database/firebase_database.dart';

class Reservation {
  String reservation_id;
  String berber_id;
  String date;
  String time;
  String service;

  Reservation.empty();

  Reservation(
      this.reservation_id, this.berber_id, this.date, this.time, this.service);

  Reservation.fromSnapshot(DataSnapshot snapshot) {
    reservation_id = snapshot.value['reservation_id'];
    berber_id = snapshot.value['berber_id'];
    date = snapshot.value['date'];
    time = snapshot.value['time'];
    service = snapshot.value['service'];
  }

  factory Reservation.fromJson(dynamic json) {
    return Reservation(
      json['reservation_id'] as String,
      json['berber_id'] as String,
      json['date'] as String,
      json['time'] as String,
      json['service'] as String,
    );
  }

  Map toJson() => {
        'reservation_id': reservation_id,
        'berber_id': berber_id,
        'date': date,
        'time': time,
        'service': service,
      };

  @override
  String toString() {
    return 'Reservation{reservation_id: $reservation_id, berber_id: $berber_id, date: $date, time: $time, service: $service}';
  }
}
