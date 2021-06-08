import 'package:firebase_database/firebase_database.dart';

class Service {
  int id;
  String name;
  int min;
  int price;
  String image;

  Service.empty();


  Service(this.id, this.name, this.min, this.price, this.image);

  Service.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.value['id'];
    name = snapshot.value['name'];
    min = snapshot.value['min'];
    price = snapshot.value['price'];
    image = snapshot.value['image'];
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      json['id'] as int,
      json['name'] as String,
      json['min'] as int,
      json['price'] as int,
      json['image'] as String,
    );
  }

  Map toJson() =>
      {
        'id': id,
        'name': name,
        'min': min,
        'price': price,
        'image': image,
      };

  @override
  String toString() {
    return 'Service{id: $id, name: $name, min: $min, price: $price, image: $image}';
  }


}
