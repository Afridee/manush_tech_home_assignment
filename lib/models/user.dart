class User {
  final String username;
  final String phone;

  User({required this.username, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
    };
  }
}
