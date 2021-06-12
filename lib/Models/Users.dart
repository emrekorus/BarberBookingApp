import 'package:firebase_database/firebase_database.dart';

class Users {
  String email;
  String name;
  String surname;
  String phone_number;
  String user_id;
  String profile_image;
  List<String> favourite_barbers;

  Users.empty();

  Users(this.email, this.name, this.surname, this.phone_number, this.user_id,
      this.profile_image, this.favourite_barbers);

  Users.fromSnapshot(DataSnapshot snapshot) {
    user_id = snapshot.key;
    name = snapshot.value['name'];
    surname = snapshot.value['surname'];
    email = snapshot.value['mail'];
    phone_number = snapshot.value['phone_number'].toString();
    profile_image = snapshot.value['profile_image'];

    var DATA = snapshot.value['favourite_barbers'];
    List<String> barbers = [];
    if (DATA != null) {
      for (var individualKey in snapshot.value['favourite_barbers'].keys) {
        barbers.add(DATA[individualKey]['id']);
      }
    }

    favourite_barbers = barbers;
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    var DATA = json['favourite_barbers'];
    List<String> barbers = [];
    for (var individualKey in json['favourite_barbers'].keys) {
      barbers.add(DATA[individualKey]['id']);
    }

    return Users(
        json['email'] as String,
        json['name'] as String,
        json['surname'] as String,
        json['phone_number'] as String,
        json['user_id'] as String,
        json['profile_image'] as String,
        barbers);
  }

  Map toJson() => {
        'email': email,
        'name': name,
        'surname': surname,
        'phone_number': phone_number,
        'user_id': user_id,
        'profile_image': profile_image,
      };

  @override
  String toString() {
    return 'Users{email: $email, name: $name, surname: $surname, phone_number: $phone_number, user_id: $user_id, profile_image: $profile_image, favourite_barbers: $favourite_barbers}';
  }
}
