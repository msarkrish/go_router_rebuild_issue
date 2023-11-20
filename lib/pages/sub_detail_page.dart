import 'package:flutter/material.dart';

class SubDetailPage extends StatefulWidget {
  const SubDetailPage({Key? key}) : super(key: key);

  @override
  State<SubDetailPage> createState() => _SubDetailPageState();
}

class _SubDetailPageState extends State<SubDetailPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Sub Detail Page Rebuilding');
    return const Scaffold(
      body: Center(
        child: Text('Sub Detail Page'),
      ),
    );
  }
}
