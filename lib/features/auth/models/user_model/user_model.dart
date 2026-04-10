import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @Default(0) int id,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String username,
    @Default('') String accessToken,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// class UserModel {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String username;
//   final String accessToken;

//   const UserModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.username,
//     required this.accessToken,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] ?? 0,
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       email: json['email'] ?? '',
//       username: json['username'] ?? '',
//       accessToken: json['accessToken'] ?? '',
//     );
//   }

//   UserModel copyWith({
//     int? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? username,
//     String? accessToken,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       username: username ?? this.username,
//       accessToken: accessToken ?? this.accessToken,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'firstName': firstName,
//     'lastName': lastName,
//     'email': email,
//     'username': username,
//   };
// }
