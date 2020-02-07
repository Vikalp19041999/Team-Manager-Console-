import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TeamView extends StatefulWidget {
  TeamView({Key key}) : super(key: key);

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  List teams;
  final String domain = "http://192.168.0.123:3000/teamList";

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
            title: Text('View Team Details'),
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
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("No of Players : " + teams[index]['players'],
                    style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("Tagline : " + teams[index]['tagline'],
                    style: TextStyle(fontSize: 18),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    ),
                    Text("Created By : " + teams[index]['createdby'],
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
