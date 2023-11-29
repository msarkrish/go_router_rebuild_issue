import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_rebuild_issue/app_routes.dart';
import 'package:go_router_rebuild_issue/data/user_data.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('List Page Rebuilding');

    return Scaffold(
      body: ListView.builder(
          itemCount: userDataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(userDataList[index].name),
              subtitle: Text(userDataList[index].country),
              onTap: () {
                GoRouter.of(context).goNamed(
                  AppRoute.detail.location,
                  pathParameters: {'id': userDataList[index].id.toString()},
                  extra: userDataList[index],
                );
              },
            );
          }),
    );
  }
}
