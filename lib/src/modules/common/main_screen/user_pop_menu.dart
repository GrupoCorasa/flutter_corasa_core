import 'package:corasa_core/src/config/constants.dart';
import 'package:corasa_core/src/modules/common/auth/auth_cubit.dart';
import 'package:corasa_core/src/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserPopMenu extends StatelessWidget {
  final Map<Widget, VoidCallback>? actions;

  const UserPopMenu({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => PopupMenuButton(
          child: ResponsiveBreakpoints.of(context).isMobile
              ? CircleAvatar(
                  child: Text(
                    StringUtils.getIniciales(state.user?.getName ?? 'N/A'),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: Text(
                    state.user?.getName ?? 'N/A',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
          itemBuilder: (context) => [
            if (actions != null)
              ...actions!.entries.map((entry) => PopupMenuItem(
                    onTap: entry.value,
                    child: entry.key,
                  )),
            PopupMenuItem(
              onTap: context.read<AuthCubit>().onLogOutRequest(context),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      );
}
