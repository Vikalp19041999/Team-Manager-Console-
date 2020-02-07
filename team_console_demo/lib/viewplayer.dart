import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PlayerView extends StatefulWidget {
  PlayerView({Key key}) : super(key: key);

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  List teams;
  final String domain = "http://192.168.0.123:3000/playerList";

  void initState() {
    super.initState();
    this.fetchPost();
  }

  Future<String> fetchPost() async {
    var response = await http.get(Uri.encodeFull(domain));
    print(response.body);

    setState(() {
      var convertToJson = json.decode(response.body);
      teams = convertToJson['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('View Player Details'),
            centerTitle: true,
            backgroundColor: Colors.green[400]),
        body: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Card(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text(
                      "Name : " + teams[index]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("Team ID : " + teams[index]['team_id'],
                    style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("Skills : " + teams[index]['skill'],
                    style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("Created By : " + teams[index]['created_by'],
                    style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                  ]))
                ],
              );
            }));
  }
}
