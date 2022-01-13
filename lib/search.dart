import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_api/profile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';

String user = '';
String user_name = '';
String image = '';
int public_repos = '' as int;
int followers = '' as int;
int following = '' as int;
List<dynamic> list = [];

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();

  Future _getUser(String text) async {
    user = text;
    _textEditingController.clear();
    String url = "https://api.github.com/users/$user";
    final repos = await http.get(Uri.parse(url));
    // http.get : json으로부터 샘플 가져오기
    Map<String, dynamic> json = jsonDecode(repos.body);

    if (repos.statusCode == 200) {
      user_name = json['login'];
      image = json['avatar_url'];
      public_repos = json['public_repos'];
      followers = json['followers'];
      following = json['following'];
      list = [user_name, image, public_repos, followers, following];
      // return All.fromJson(json.decode(repos.body));
      // 서버가 OK 응답을 반환하면 json을 파싱함

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    } else {
      throw Exception("Failed to fetch repos");
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Page'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                  child: TextField(
                controller: _textEditingController,
                //onChanged: _getUser,
                decoration: InputDecoration.collapsed(
                    hintText: "Enter Github Username"),
              )),
              Container(
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _getUser((_textEditingController.text));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
