import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_api/search.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        height: 120,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        margin: const EdgeInsets.only(right: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: Image.network(
                '$image',
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 30),
                Text('Public Repo : $public_repos'),
                SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    Text('Followers : $followers'),
                    SizedBox(width: 15),
                    Text('Following : $following')
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
