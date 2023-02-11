class Users {
  int id;
  String? email, firstName, lastName, avatar, support, name, job, createdAt;

  Users({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.support,
    this.name,
    this.job,
    this.createdAt,
  });

  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
