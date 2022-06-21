class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? type;
  String? token;

  User({this.id, this.name, this.image, this.email, this.token,this.type});

  //function to convert json data to user models
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
        email: json['user']['email'],
        type: json['type'],
        token: json['token']
        // se deixar dessa maneira, depois de fazer login quando fzer restart vai te levar a pagina de login token: json['user']['token'],
        );
  }

/* 
Outra maneira

 factory User.createData(Map<String, dynamic> object) {
    return User(
      id: object['user']['id'],
      name: object['user']['name'],
      image: object['user']['image'],
      email: object['user']['email'],
      token: object['user']['token'],
    );
  }




*/

}
