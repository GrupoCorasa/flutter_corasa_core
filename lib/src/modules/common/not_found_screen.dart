import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  static router() => MaterialPage(
        key: UniqueKey(),
        name: 'Not Found',
        child: const NotFoundScreen(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error 404'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => GoRouter.of(context).pop(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red,
              Colors.blue,
            ],
          )),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: const Image(
                    image: AssetImage('assets/error-404.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
