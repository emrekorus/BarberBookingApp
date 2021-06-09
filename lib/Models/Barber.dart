import 'package:firebase_database/firebase_database.dart';
import 'package:my_barber/Models/Personels.dart';
import 'package:my_barber/Models/Review.dart';

class Barber {
  String ID;
  String about;
  String address;
  String image;
  double latitude;
  double longitude;
  String name;
  List<Personal> personals;
  List<Review> reviews;
  double stars;
  double distance;

  Barber.empty();

  Barber(this.ID, this.about, this.address, this.image, this.latitude,
      this.longitude, this.name, this.personals, this.reviews, this.stars);

/*
  Barber.map(dynamic obj) {
    ID = obj['ID'];
    about = obj['about'];
    address = obj['address'];
    image = obj['image'];
    latitude = snapshot.value['latitude'];
    longitude = snapshot.value['longitude'];
    name = snapshot.value['name'];
    personals = personalList;
    reviews = reviewList;
    stars = snapshot.value['stars'];
  }*/

  Barber.fromSnapshot(DataSnapshot snapshot) {
    var list = snapshot.value['personels'] as List;
    List<Personal> personalList =
        list.map((i) => Personal.fromSnapshot(i)).toList();

    var list2 = snapshot.value['reviews'] as List;
    List<Review> reviewList = list2.map((i) => Review.fromSnapshot(i)).toList();

    ID = snapshot.key;
    about = snapshot.value['about'];
    address = snapshot.value['address'];
    image = snapshot.value['image'];
    latitude = snapshot.value['latitude'];
    longitude = snapshot.value['longitude'];
    name = snapshot.value['name'];
    personals = personalList;
    reviews = reviewList;
    stars = snapshot.value['stars'];
  }

  factory Barber.fromJson(dynamic json) {
    var list = json['personels'];
    List<Personal> personalList = [];
    for (var individualKey in list.keys) {
      Personal personal = Personal.fromJson(list[individualKey]);
      personalList.add(personal);
    }

    var list2 = json['reviews'];
    List<Review> reviewList = [];
    if (list2 != null){
      for (var individualKey in list2.keys) {
        Review review = Review.fromJson(list2[individualKey]);
        reviewList.add(review);
      }
    }


    return Barber(
      json['ID'] as String,
      json['about'] as String,
      json['address'] as String,
      json['image'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['name'] as String,
      personalList,
      reviewList,
      json['stars'] as double,
    );
  }

  Map toJson() {
    List<Map> personals = this.personals != null
        ? this.personals.map((i) => i.toJson()).toList()
        : null;
    List<Map> reviews = this.reviews != null
        ? this.reviews.map((i) => i.toJson()).toList()
        : null;

    return {
      'ID': ID,
      'about': about,
      'address': address,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'personalList': personals,
      'reviews': reviews,
      'stars': stars,
    };
  }

  @override
  String toString() {
    return 'Barber{ID: $ID, about: $about, address: $address, image: $image, latitude: $latitude, longitude: $longitude, name: $name, personals: $personals, reviews: $reviews, stars: $stars}';
  }
}
