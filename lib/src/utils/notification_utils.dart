import 'dart:developer';

import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/exception/response_exception.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NotificationUtils {
  const NotificationUtils._();

  static void invalidForm(BuildContext context) {
    ElegantNotification.error(
      title: const Text('Errores en el formulario'),
      description: const Text('Verifique los campos marcados en rojo'),
      toastDuration: Constants.errorDuration,
    ).show(context);
  }

  static ElegantNotification onStacktrace(
    final context,
    final Object? error,
    final StackTrace stacktrace,
  ) {
    if (error is ResponseException) {
      return ElegantNotification.error(
        title: Text(error.message ?? 'Ocurrió un error en el proceso'),
        description: Text(error.details?.join('\n') ??
            'Por favor, contacte a soporte técnico'),
        toastDuration: Constants.errorDuration,
      )..show(context);
    } else if (error is ClientException) {
      return ElegantNotification.error(
        title: const Text('Error al realizar la conexión al servidor'),
        description: const Text('Verifique su conexión a internet'),
        toastDuration: Constants.errorDuration,
      )..show(context);
    }
    log("Ocurrió un error: ", error: error, stackTrace: stacktrace);
    return ElegantNotification.error(
      title: const Text('Ocurrió un error en el proceso'),
      description:
          Text('Por favor, contacte a soporte técnico\n${error.toString()}'),
      toastDuration: Constants.errorDuration,
    )..show(context);
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
}
