import 'package:firebase_database/firebase_database.dart';

class Review {
  String id;
  String comment;
  int star;
  int time;
  String user;

  Review.empty();

  Review(this.id, this.comment, this.star, this.time, this.user);

  Review.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    comment = snapshot.value['comment'];
    star = snapshot.value['star'];
    time = snapshot.value['time'];
    user = snapshot.value['user'];
  }

  factory Review.fromJson(dynamic json) {
    return Review(
      json['id'] as String,
      json['comment'] as String,
      json['star'] as int,
      json['time'] as int,
      json['user'] as String,
    );
  }

  Map toJson() => {
        'id': id,
        'comment': comment,
        'star': star,
        'time': time,
        'user': user,
      };

  @override
  String toString() {
    return 'Review{id: $id, comment: $comment, star: $star, time: $time, user: $user}';
  }
}
