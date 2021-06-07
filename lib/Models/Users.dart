import 'package:firebase_database/firebase_database.dart';
class Users {
  String email;
  String name;
  String surname;
  String phone_number;
  String user_id;
  String profile_image;

  Users.empty();


  Users(this.email, this.name, this.surname, this.phone_number, this.user_id, this.profile_image);

  Users.fromSnapshot(DataSnapshot snapshot) {
    user_id = snapshot.key;
    name = snapshot.value['name'];
    surname = snapshot.value['surname'];
    email = snapshot.value['mail'];
    phone_number = snapshot.value['phone_number'].toString();
    profile_image = snapshot.value['profile_image'];
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      json['email'] as String,
      json['name'] as String,
      json['surname'] as String,
      json['phone_number'] as String,
      json['user_id'] as String,
      json['profile_image'] as String,
    );
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
    return 'Users{email: $email, name: $name, surname: $surname, phone_number: $phone_number, user_id: $user_id, profile_image: $profile_image}';
  }
}
