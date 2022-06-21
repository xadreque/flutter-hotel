import 'package:busness_in_touch/models/user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  int? likerCount;
  int? commentsCount;
  User? user;
  bool? selfLiked;
  Post(
      {this.id,
      this.body,
      this.image,
      this.likerCount,
      this.commentsCount,
      this.user,
      this.selfLiked});
  //Mapiamento do Post Usuando Map

  factory Post.fromJoson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      body: json['body'],
      image: json['image'],
      likerCount: json['likes_count'],
      commentsCount: json['comments_count'],
      selfLiked: json['likes'].length >0,
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image']
      ),
    );
  }
}
