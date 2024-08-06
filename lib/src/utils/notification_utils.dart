import 'dart:developer';

import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:corasa_core/src/model/generic_response.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';

class NotificationUtils {
  const NotificationUtils._();

  static void invalidForm(BuildContext context) {
    ElegantNotification.error(
      title: const Text('Errores en el formulario'),
      description: const Text('Verifique los campos marcados en rojo'),
      toastDuration: Constants.errorDuration,
    ).show(context);
  }

  static void onStacktrace(
    final context,
    final Object? error,
    final StackTrace stacktrace,
  ) {
    if (error is ResponseException) {
      QuickAlert.show(
        context: context,
        title: error.message ?? 'Ocurrió un error en el proceso',
        type: QuickAlertType.error,
        text: error.details?.join('\n') ??
            'Por favor, contacte a soporte técnico',
      );
      return;
    } else if (error is ClientException) {
      QuickAlert.show(
        context: context,
        title: 'Error al realizar la conexión al servidor',
        type: QuickAlertType.error,
        text: 'Verifique su conexión a internet',
      );
      return;
    }
    log('Ocurrió un error: ', error: error, stackTrace: stacktrace);
    QuickAlert.show(
      context: context,
      title: 'Ocurrió un error en el proceso',
      type: QuickAlertType.error,
      text: 'Por favor, contacte a soporte técnico\n${error.toString()}',
    );
  }

  static Future<T> asyncNotification<T>(BuildContext context, Future task,
      String description, String finishMessage) async {
    ElegantNotification notification = ElegantNotification(
      title: const Text('Procesando'),
      description: Text(
        description,
        overflow: TextOverflow.ellipsis,
      ),
      icon: const Icon(Icons.timer),
      showProgressIndicator: false,
      displayCloseButton: false,
      autoDismiss: false,
      isDismissable: false,
    )..show(context);
    try {
      return await task;
    } finally {
      notification.closeOverlay();
      if (context.mounted) {
        ElegantNotification.info(
          title: const Text('Proceso Terminado'),
          description: Text(
            finishMessage,
            overflow: TextOverflow.ellipsis,
          ),
          toastDuration: Constants.errorDuration,
        ).show(context);
      }
    }
  }

  static ElegantNotification manualNotification(
    final BuildContext context,
    final bool? success,
    final String title,
    final String message,
  ) =>
      success == null
          ? (ElegantNotification.info(
              title: Text(title),
              description: Text(message),
              background: Theme.of(context).colorScheme.surface,
              toastDuration: Constants.successDuration * 5,
            )..show(context))
          : success
              ? (ElegantNotification.success(
                  title: Text(title),
                  description: Text(message),
                  background: Theme.of(context).colorScheme.surface,
                  toastDuration: Constants.successDuration,
                )..show(context))
              : (ElegantNotification.error(
                  title: Text(title),
                  description: Text(message),
                  background: Theme.of(context).colorScheme.surface,
                  toastDuration: Constants.errorDuration,
                )..show(context));

  static Future<void> confirmDialog(BuildContext context, String title,
          String text, VoidCallback onConfirmBtnTap,
          {String confirmBtn = 'Confirmar',
          String cancelBtn = 'Cancelar',
          Color confirmColor = Colors.green,
          VoidCallback? onCancelBtnTap}) async =>
      QuickAlert.show(
        context: context,
        title: title,
        type: QuickAlertType.confirm,
        text: text,
        confirmBtnText: confirmBtn,
        cancelBtnText: cancelBtn,
        confirmBtnColor: confirmColor.withOpacity(0.7),
        onConfirmBtnTap: onConfirmBtnTap,
        onCancelBtnTap: onCancelBtnTap ?? () => Navigator.pop(context),
        showConfirmBtn: true,
        showCancelBtn: true,
        disableBackBtn: false,
      );

  static Future<void> inputDialog(BuildContext context, String title,
      String text, void Function(String?) onConfirmBtnTap,
      {String confirmBtn = 'Confirmar',
      String cancelBtn = 'Cancelar',
      Color confirmColor = Colors.green,
      VoidCallback? onCancelBtnTap}) async {
    String? input;
    await QuickAlert.show(
      context: context,
      title: title,
      type: QuickAlertType.custom,
      text: text,
      barrierDismissible: true,
      confirmBtnText: 'Enviar',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Correo electrónico',
          prefixIcon: Icon(Icons.email),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => input = value,
      ),
      onConfirmBtnTap: () => onConfirmBtnTap(input),
    );
  }

  static Future<void> onGenericResponse(
          BuildContext context, GenericResponse response, bool success) async =>
      QuickAlert.show(
        context: context,
        title: response.message,
        type: success ? QuickAlertType.success : QuickAlertType.error,
        text: response.details?.join('\n'),
      );
}
