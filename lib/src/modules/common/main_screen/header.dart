import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/modules/common/auth/auth_cubit.dart';
import 'package:corasa_core/src/modules/common/main_screen/user_pop_menu.dart';
import 'package:corasa_core/src/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget {
  final String title;
  final Map<Widget, VoidCallback>? headerActions;

  final ValueChanged<String>? onSearchEvent;
  final List<Widget>? additional;
  final Widget? endWidget;

  const Header({
    super.key,
    required this.title,
    required this.headerActions,
    this.onSearchEvent,
    this.additional,
    this.endWidget,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: additional == null && onSearchEvent != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(context),
                      searchBar(context),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(context),
                      if (additional != null || onSearchEvent != null)
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            if (onSearchEvent != null) searchBar(context),
                            if (additional != null) ...additional!,
                          ],
                        ),
                    ],
                  ),
          ),
          if (endWidget != null) endWidget!,
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => UserPopMenu(actions: headerActions),
          ),
        ],
      );

  Widget titleText(BuildContext context) => Text(
        title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: Theme.of(context).textTheme.headlineLarge,
      );

  Widget searchBar(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
        width: 200,
        child: TextField(
          onChanged: onSearchEvent,
          decoration: FormUtils.inputDecoration('Busqueda', Icons.search),
        ),
      );
}
