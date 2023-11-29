import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/data/user_data.dart';

class DetailPage extends StatefulWidget {
  final UserData userData;
  const DetailPage({required this.userData, Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Detail Page Rebuilding');
    final Map<String, dynamic> pParams =
        GoRouterState.of(context).pathParameters;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.userData.name),
            const SizedBox(
              height: 8,
            ),
            FilledButton(
              onPressed: () {
                GoRouter.of(context).goNamed(
                  AppRoute.subdetail.location,
                  pathParameters: {
                    'id': pParams['id'].toString(),
                  },
                  extra: widget.userData,
                );
              },
              child: const Text(
                'Go to Sub Detail',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
