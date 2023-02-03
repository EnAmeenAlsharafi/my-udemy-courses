import 'package:flutter/material.dart';
import 'package:my_udemy_apps/models/user/user_model.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 2, name: 'Ameen', phone: '777777'),
    UserModel(id: 3, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 4, name: 'Ameen', phone: '777777'),
    UserModel(id: 5, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 6, name: 'Ameen', phone: '777777'),
    UserModel(id: 7, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 8, name: 'Ameen', phone: '777777'),
    UserModel(id: 9, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 10, name: 'Ameen', phone: '777777'),
    UserModel(id: 12, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 13, name: 'Ameen', phone: '777777'),
    UserModel(id: 14, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 15, name: 'Ameen', phone: '777777'),
    UserModel(id: 16, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 17, name: 'Ameen', phone: '777777'),
    UserModel(id: 18, name: 'salah Ahmed', phone: '777777878'),
    UserModel(id: 19, name: 'Ameen', phone: '777777'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
      ),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.only(start: 10, top: 15, bottom: 10),
        child: ListView.separated(
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return BuildItem(users[index]);
          },
        ),
      ),
    );
  }

  //1-build item
  //2-create list
  //3-send item to list
  Widget BuildItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              child: Text('${user.id}'),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('${user.name}'), Text('${user.phone}')],
            )
          ],
        ),
      );
}
