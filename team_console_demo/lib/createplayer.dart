import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:team_console_demo/welcome.dart';

final String domain = "192.168.0.123:3000";

class CreatePlayer extends StatefulWidget {
  CreatePlayer({Key key}) : super(key: key);

  @override
  _CreatePlayerState createState() => _CreatePlayerState();
}

class _CreatePlayerState extends State<CreatePlayer> {
//*CONNECTION WITH API
  String name_text, teamName_text, skills_text, createdBy_text;
  TextEditingController name = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController createdBy = TextEditingController();
  bool rememberMe = false;

  Future<http.Response> playerRegister() async {
    Map body = {
      'name': name.text.toString(),
      'teamName': teamName.text.toString(),
      'skills': skills.text.toString(),
      'createdBy': createdBy.text.toString()
    };
    return http
        .post('http://$domain/playerCreate', body: body)
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
          title: Text('Create the Player'),
          centerTitle: true,
          backgroundColor: Colors.green[400],
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/player.png', height: 200),
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
                            labelText: "Team Name",
                          ),
                          keyboardType: TextInputType.text,
                          controller: teamName,
                          onChanged: (a) {
                            teamName_text = null;
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: "Skills",
                          ),
                          keyboardType: TextInputType.text,
                          controller: skills,
                          onChanged: (a) {
                            skills_text = null;
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
                        child: Text('Register Player'),
                        splashColor: Colors.redAccent,
                        onPressed: () {
                          if (name.text == '' &&
                              teamName.text == '' &&
                              skills.text == '' &&
                              createdBy.text == '') {
                            setState(() {
                              name_text = 'Enter Player Name';
                              teamName_text = 'Enter the Team Name';
                              skills_text = 'Enter the Skills';
                              createdBy_text = 'Enter Owner of the Team';
                            });
                          } else if (name.text == '') {
                            setState(() {
                              name_text = 'Enter Player Name';
                            });
                          } else if (teamName.text == '') {
                            setState(() {
                              teamName_text = 'Enter the Team Name';
                            });
                          } else if (skills.text == '') {
                            setState(() {
                              skills_text = 'Enter the Skills';
                            });
                          } else if (createdBy.text == '') {
                            setState(() {
                              createdBy_text = 'Enter Owner of the Team';
                            });
                          } else {
                            playerRegister();
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
