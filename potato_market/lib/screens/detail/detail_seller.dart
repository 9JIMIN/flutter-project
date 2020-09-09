import 'package:flutter/material.dart';
import '../../models/profile.dart';
import '../../helpers/db_helper_profile.dart';

class DetailSeller extends StatelessWidget {
  Future<Profile> getProfile(id) async {
    Profile profile = await DBHelperProfile.findById(id);
    return profile;
  }

  final product;
  DetailSeller(this.product);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProfile(product.sellerId),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(product.imageUrls[0]),
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
                  Column(
                    children: [Text('온도'), Icon(Icons.hot_tub)],
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
