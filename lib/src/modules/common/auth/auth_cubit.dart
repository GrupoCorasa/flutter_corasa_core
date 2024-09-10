import 'package:corasa_core/corasa_core.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(ImageProvider logo)
      : super(AuthState(
          sideMenucontroller: SideMenuController(),
          logo: logo,
        ));

  VoidCallback onLogOutRequest(BuildContext context) => () {
        context.read<ApiService>().cleanToken();
        GoRouter.of(context).replace('/');
        emit(state.copyWith(clearUser: true));
      };

  void loggedIn(CoreUser? usuario) => emit(state.copyWith(user: usuario));
}
