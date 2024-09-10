import 'dart:async';
import 'dart:math';

import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/model/login_request.dart';
import 'package:corasa_core/src/modules/common/auth/auth_cubit.dart';
import 'package:corasa_core/src/modules/common/login_screen/login_cubit.dart';
import 'package:corasa_core/src/utils/form_utils.dart';
import 'package:corasa_core/src/utils/notification_utils.dart';
import 'package:corasa_core/src/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatelessWidget {
  final Random random = Random();
  final List<String>? backgroundAssets;
  final GlobalKey<FormBuilderState> formKey;
  final Future<void> Function(LoginRequest request) onLogin;
  final Future<void> Function() onLogged;
  final Widget? additional;

  LoginScreen({
    super.key,
    required this.formKey,
    this.backgroundAssets,
    required this.onLogin,
    required this.onLogged,
    this.additional,
  }) {
    onLogged();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
          decoration: backgroundAssets == null
              ? null
              : BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundAssets!
                        .elementAt(random.nextInt(backgroundAssets!.length))),
                    fit: BoxFit.cover,
                  ),
                ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                constraints: const BoxConstraints(
                  maxWidth: Constants.oneColumnWidth,
                ),
                decoration: UiUtils.boxDecoration(context),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) => Image(image: state.logo),
                      ),
                      FormUtils.separator(),
                      FormBuilderTextField(
                        name: 'username',
                        validator: FormUtils.stringValidation(
                          'El usuario',
                          required: true,
                          min: 3,
                          max: 25,
                        ),
                        decoration: FormUtils.inputDecoration(
                          'Usuario',
                          Icons.supervisor_account,
                        ),
                        onChanged:
                            context.read<LoginCubit>().onChangeUsername(),
                        valueTransformer: (text) => text?.toLowerCase().trim(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      FormUtils.separator(),
                      FormBuilderTextField(
                        name: 'password',
                        validator: FormUtils.stringValidation(
                          'La contraseña',
                          required: true,
                          min: 5,
                        ),
                        decoration: FormUtils.inputDecoration(
                          'Constraseña',
                          Icons.lock,
                        ),
                        onChanged:
                            context.read<LoginCubit>().onChangePassword(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),
                      FormUtils.separator(),
                      FormBuilderSwitch(
                        name: 'remember',
                        title: const Text(
                          'Recordar Usuario',
                          overflow: TextOverflow.ellipsis,
                        ),
                        onChanged:
                            context.read<LoginCubit>().onChangeRemember(),
                      ),
                      FormUtils.separator(),
                      FormUtils.submitButton('Iniciar Sesión', () {
                        if (!formKey.currentState!.validate()) {
                          NotificationUtils.invalidForm(context);
                          return;
                        }
                        NotificationUtils.asyncNotification(
                          context,
                          onLogin(context.read<LoginCubit>().onSubmit()),
                          'Iniciando Sesión',
                          'Proceso terminado',
                        )
                            .then((token) => onLogged())
                            .onError((error, stackTrace) {
                          if (context.mounted) {
                            NotificationUtils.onStacktrace(
                              context,
                              error,
                              stackTrace,
                            );
                          }
                        });
                      }),
                      if (additional != null) ...[
                        FormUtils.separator(),
                        additional!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
