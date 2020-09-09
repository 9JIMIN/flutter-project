import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../helpers/db_helper_profile.dart';

class MyPageColumn extends StatelessWidget {
  static const routeName = '/profile';

  Future getUser() async {
    final user =
        await DBHelperProfile.findById(FirebaseAuth.instance.currentUser.uid);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        FutureBuilder(
            future: getUser(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(snapshot.data.image),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(snapshot.data.email),
                      ],
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text('프로필 보기'),
                      onPressed: () {},
                    )
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ]),
    );
  }
}
