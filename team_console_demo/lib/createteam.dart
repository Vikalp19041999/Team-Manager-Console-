import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:team_console_demo/welcome.dart';

final String domain = "192.168.0.123:3000";

class CreateTeam extends StatefulWidget {
  CreateTeam({Key key}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
//*CONNECTION WITH API
  String name_text, players_text, tagline_text, createdBy_text;
  TextEditingController name = TextEditingController();
  TextEditingController players = TextEditingController();
  TextEditingController tagline = TextEditingController();
  TextEditingController createdBy = TextEditingController();
  bool rememberMe = false;

  Future<http.Response> teamRegister() async {
    Map body = {
      'name': name.text.toString(),
      'players': players.text,
      'tagline': tagline.text.toString(),
      'createdBy': createdBy.text.toString()
    };
    return http
        .post('http://$domain/teamCreate', body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      print(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create the Team'),
          centerTitle: true,
          backgroundColor: Colors.green[400],
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/team.png', height: 200),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Form(
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          keyboardType: TextInputType.text,
                          controller: name,
                          onChanged: (a) {
                            name_text = null;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "No of Players",
                          ),
                          keyboardType: TextInputType.number,
                          controller: players,
                          onChanged: (a) {
                            players_text = null;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Tagline",
                          ),
                          keyboardType: TextInputType.text,
                          controller: tagline,
                          onChanged: (a) {
                            tagline_text = null;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Created by",
                          ),
                          keyboardType: TextInputType.text,
                          controller: createdBy,
                          onChanged: (a) {
                            createdBy_text = null;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text('Register Team'),
                        splashColor: Colors.redAccent,
                        onPressed: () {
                          if (name.text == '' &&
                              players.text == '' &&
                              tagline.text == '' &&
                              createdBy.text == '') {
                            setState(() {
                              name_text = 'Enter Team Name';
                              players_text = 'Enter Number of Players';
                              tagline_text = 'Enter Tagline';
                              createdBy_text = 'Enter Owner of the Team';
                            });
                          } else if (name.text == '') {
                            setState(() {
                              name_text = 'Enter Team Name';
                            });
                          } else if (players.text == '') {
                            setState(() {
                              players_text = 'Enter Number of Players';
                            });
                          } else if (tagline.text == '') {
                            setState(() {
                              tagline_text = 'Enter Tagline';
                            });
                          } else if (createdBy.text == '') {
                            setState(() {
                              createdBy_text = 'Enter Owner of the Team';
                            });
                          } else {
                            teamRegister();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
