import 'package:go_router_rebuild_issue/providers/list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedDetail extends _$SelectedDetail {
  @override
  UserData build() {
    return UserData(id: 0, name: '', country: '');
  }

  void changeUserDetail({required UserData userData}) {
    state = userData;
  }
}
