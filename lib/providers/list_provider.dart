import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_provider.g.dart';

@riverpod

List<UserData> userList(UserListRef ref)
{
  return userDataList;
}


List<UserData> userDataList = <UserData>[
  UserData(id: 1,name: 'Virat Kohli', country: 'India'),
  UserData(id: 2,name: 'Novak', country: 'Serbia'),
  UserData(id: 3,name: 'John Cena', country: 'USA'),
  UserData(id: 4,name: 'Rupinder Pal Singh', country: 'India'),
  UserData(id: 5,name: 'Ajith Kumar', country: 'India'),
];

class UserData {
  final int id;
  final String name;
  final String country;

  UserData({required this.id, required this.name, required this.country});
}