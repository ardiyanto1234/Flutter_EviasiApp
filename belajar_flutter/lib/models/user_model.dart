class UserModel {
  final int? idUser;
  final String? name;
  final String? username;
  final String? email;
  final String? noHp;
  final String? password;
  final String? alamat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.idUser,
    this.name,
    this.username,
    this.email,
    this.noHp,
    this.password,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json['id_user'] as int,
        name: json['name'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        noHp: json['no_hp'] as String?,
        password: json['password'] as String,
        alamat: json['alamat'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'name': name,
        'username': username,
        'email': email,
        'no_hp': noHp,
        'password': password,
        'alamat': alamat,
        'created_at': createdAt.toString(),
        'updated_at': updatedAt.toString(),
      };
}
