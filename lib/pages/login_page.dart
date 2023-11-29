import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
            onPressed: () {
              GoRouter.of(context).goNamed(
                AppRoute.dashboard.location,
              );
            },
            child: const Text('Login')),
      ),
    );
  }
}
