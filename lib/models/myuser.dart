class Myuser {
  static Myuser? currentUser;
  late String id;
  late String email;
  late String userName;

  Myuser({required this.id, required this.email, required this.userName});

  Myuser.fromJson(Map json) {
    id = json["id"];
    email = json["email"];
    userName = json["userName"];
  }

  Map<String, Object> toJson() {
    return {"id": id, "email": email, "userName": userName};
  }
}
