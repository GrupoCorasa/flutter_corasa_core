import 'package:corasa_core/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormUtils {
  const FormUtils._();

  static SizedBox separator({bool horizontal = false}) => SizedBox(
        width: horizontal ? Constants.defaultGap : null,
        height: horizontal ? null : Constants.defaultGap,
      );

  static InputDecorationTheme inputDecorationTheme({
    final double borderRadius = 30.0,
    isDense = true,
  }) =>
      InputDecorationTheme(
        filled: true,
        isDense: isDense,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          gapPadding: 4.0,
        ),
      );

  static InputDecoration inputDecoration(
    final String label,
    final IconData icon,
  ) =>
      InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          gapPadding: 4.0,
        ),
      );

  static ButtonStyle submitDecoration({final Color? backgroundColor}) =>
      ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: backgroundColor,
      );

  static Widget submitButton(
    final String label,
    final Function() onPressed, {
    final Color? backgroundColor,
  }) =>
      SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: submitDecoration(backgroundColor: backgroundColor),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  static FormFieldValidator<String> stringValidation(
    String description, {
    bool required = false,
    bool numeric = false,
    bool email = false,
    int? min,
    int? max,
    String? equals,
  }) =>
      FormBuilderValidators.compose([
        if (required)
          FormBuilderValidators.required(
            errorText: '$description es obligatorio',
          ),
        if (min != null && numeric)
          FormBuilderValidators.min(
            min,
            errorText: '$description debe ser mayor a $min',
          ),
        if (min != null && !numeric)
          FormBuilderValidators.minLength(
            min,
            checkNullOrEmpty: !required,
            errorText: '$description debe ser mayor a $min caracteres',
          ),
        if (max != null && numeric)
          FormBuilderValidators.max(
            max,
            errorText: '$description debe ser menor a $max',
          ),
        if (max != null && !numeric)
          FormBuilderValidators.maxLength(
            max,
            errorText: '$description debe ser menor a $max caracteres',
          ),
        if (equals != null)
          FormBuilderValidators.equal(
            equals,
            errorText: '$description incorrecta',
          ),
        if (numeric)
          FormBuilderValidators.numeric(
            errorText: '$description debe ser numérico',
          ),
        if (email)
          FormBuilderValidators.email(
            errorText: '$description debe ser un correo electrónico válido',
          ),
      ]);

  static FormFieldValidator<DateTime> dateValidation(
    String description, {
    bool required = false,
  }) =>
      FormBuilderValidators.compose([
        if (required)
          FormBuilderValidators.required(
            errorText: '$description es obligatorio',
          ),
      ]);

  static FormFieldValidator<T> typeValidation<T>(
    String description, {
    bool required = false,
  }) =>
      FormBuilderValidators.compose([
        if (required)
          FormBuilderValidators.required(
            errorText: '$description es obligatorio',
          ),
      ]);
}
