import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/providers/detail_provider.dart';
import 'package:go_router_rebuild_issue/providers/list_provider.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('List Page Rebuilding');

    final userDataList = ref.watch(userListProvider);

    return Scaffold(
      body: ListView.builder(
          itemCount: userDataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(userDataList[index].name),
              subtitle: Text(userDataList[index].country),
              onTap: () {
                ref
                    .read(selectedDetailProvider.notifier)
                    .changeUserDetail(userData: userDataList[index]);
                GoRouter.of(context).goNamed(
                  AppRoute.detail.location,
                  pathParameters: {'id': userDataList[index].id.toString()},
                );
              },
            );
          }),
    );
  }
}
