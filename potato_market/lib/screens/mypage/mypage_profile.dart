import 'package:flutter/material.dart';

import '../../helpers/db_helper_profile.dart';

class MyPageProfile extends StatelessWidget {
  final userId;
  MyPageProfile(this.userId);

  Future getUser() async {
    final user = await DBHelperProfile.getProfileById(userId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: FutureBuilder(
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black38),
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
