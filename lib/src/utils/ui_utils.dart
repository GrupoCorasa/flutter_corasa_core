import 'package:corasa_core/src/config/constants.dart';
import 'package:flutter/material.dart';

class UiUtils {
  const UiUtils._();

  static BoxDecoration boxDecoration(
    final BuildContext context, {
    final Color? backgroundColor,
    final double opacity = 0.7,
    final double borderRadius = 40.0,
  }) =>
      BoxDecoration(
        color: backgroundColor ??
            Theme.of(context).colorScheme.surface.withOpacity(opacity),
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      );

  static FloatingActionButton addNew(final VoidCallback onPress,
          {final IconData icon = Icons.add}) =>
      FloatingActionButton(
        onPressed: onPress,
        child: Icon(
          icon,
          size: 24.0,
        ),
      );

  static ButtonStyle submitDecoration({
    final Color? backgroundColor,
    final double borderRadius = 30.0,
  }) =>
      ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      );

  static Container generateChip(String label, Color bgColor, Color textColor) =>
      Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  static Stack sectionWithTitle(
          BuildContext context, String title, Widget child,
          {EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          Color? textBackground}) =>
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: Constants.defaultGap),
            padding: padding ?? const EdgeInsets.all(Constants.defaultPadding),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: child,
          ),
          Positioned(
            top: 0,
            left: 40,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.defaultGap),
              decoration: BoxDecoration(
                color: textBackground ?? Theme.of(context).colorScheme.surface,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
}
