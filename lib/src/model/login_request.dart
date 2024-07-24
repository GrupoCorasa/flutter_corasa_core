import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String? username;
  final String? password;
  final bool? remember;

  const LoginRequest({this.username, this.password, this.remember});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'remember': remember,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'],
      password: map['password'],
      remember: map['remember'],
    );
  }

  @override
  List<Object?> get props => [username, password, remember];
}
