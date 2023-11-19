class UserDataModel {
  String? eMail;
  String? password;
  String name;
  String token;
  String phoneNumber;

  UserDataModel({
    this.eMail,
    this.password,
    required this.token,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'e_mail': eMail,
      'password': password,
      'token': token,
      'name': name,
      'phoneNumber': phoneNumber
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      eMail: json['e_mail'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  @override
  String toString() =>
      "UserDataModel(eMail: $eMail,password: $password,token: $token, phone number: $phoneNumber)";

  @override
  int get hashCode => Object.hash(eMail, password, token, name, phoneNumber);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModel &&
          runtimeType == other.runtimeType &&
          eMail == other.eMail &&
          password == other.password &&
          token == other.token &&
          name == other.name &&
          phoneNumber == other.phoneNumber;
}
