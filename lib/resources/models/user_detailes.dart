class UserDetailsModel {
  final String name;
  final String phone;
  final String type;
  final String password;
  UserDetailsModel( {required this.name, required this.type, required this.phone, required this.password,});

  Map<String, dynamic> getJson() => {
    'name': name,
    'phone': phone,
    'type' : type,
    'password': password
  };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], phone: json["phone"], type: json["type"], password :json["password"] );
  }
}