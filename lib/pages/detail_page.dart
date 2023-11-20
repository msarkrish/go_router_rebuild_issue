import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/providers/detail_provider.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Detail Page Rebuilding');
    final userDetailProvider = ref.watch(selectedDetailProvider);
    final Map<String, dynamic> pParams =
        GoRouterState.of(context).pathParameters;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userDetailProvider.name),
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
