import 'package:corasa_core/src/model/login_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  ValueChanged<String?> onChangeUsername() =>
      (value) => emit(state.copyWith(username: value ?? ''));

  ValueChanged<String?> onChangePassword() =>
      (value) => emit(state.copyWith(password: value ?? ''));

  ValueChanged<bool?> onChangeRemember() =>
      (value) => emit(state.copyWith(remember: value));

  LoginRequest onSubmit() => LoginRequest(
        username: state.username,
        password: state.password,
        remember: state.remember,
      );
}
