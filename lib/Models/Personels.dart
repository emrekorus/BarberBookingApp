import 'package:firebase_database/firebase_database.dart';

class Personal {
  String id;
  String barber_name;

  Personal.empty();

  Personal(this.id, this.barber_name);

  Personal.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    barber_name = snapshot.value['barber_name'];
  }

  factory Personal.fromJson(dynamic json) {
    return Personal(
      json['id'] as String,
      json['barber_name'] as String,
    );
  }

  Map toJson() => {
        'id': id,
        'barber_name': barber_name,
      };

  @override
  String toString() {
    return 'Personel{id: $id, barber_name: $barber_name}';
  }
}
