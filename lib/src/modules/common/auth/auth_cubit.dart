import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/model/core_user.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(ImageProvider logo)
      : super(AuthState(
          sideMenucontroller: SideMenuController(),
          logo: logo,
        ));

  VoidCallback onLogOutRequest(BuildContext context) => () {
        SharedPreferences.getInstance()
            .then((instance) => instance.remove(Constants.storageJwtKey));
        if (state.user != null) {
          state.user!.onLogout(context);
        }
        GoRouter.of(context).replace('/');
        emit(state.copyWith(clearUser: true));
      };

  void loggedIn(CoreUser? usuario) => emit(state.copyWith(user: usuario));
}
