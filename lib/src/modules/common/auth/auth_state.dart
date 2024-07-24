part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool loading;
  final ImageProvider logo;
  final CoreUser? user;
  final SideMenuController sideMenucontroller;

  const AuthState({
    this.loading = false,
    required this.logo,
    this.user,
    required this.sideMenucontroller,
  });

  AuthState copyWith({
    bool? loading,
    ImageProvider? logo,
    bool? clearUser,
    CoreUser? user,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      logo: logo ?? this.logo,
      user: clearUser == true ? null : user ?? this.user,
      sideMenucontroller: sideMenucontroller,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        logo,
        user,
        sideMenucontroller,
      ];
}
