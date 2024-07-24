part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? username;
  final String? password;
  final bool remember;

  const LoginState({
    this.isLoading = false,
    this.username,
    this.password,
    this.remember = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? username,
    String? password,
    bool? remember,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      username: username ?? this.username,
      password: password ?? this.password,
      remember: remember ?? this.remember,
    );
  }

  @override
  List<Object?> get props => [isLoading, username, password, remember];
}
