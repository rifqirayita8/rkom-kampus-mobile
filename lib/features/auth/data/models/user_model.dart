import 'package:rkom_kampus/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name, 
    required super.email, 
    required super.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'], 
      email: json['email'], 
      password: json['password']
    );
  }
  
}