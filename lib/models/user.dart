class User {
  String name;
  String email;
  String avatar;

  User({this.name, this.email});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];
}