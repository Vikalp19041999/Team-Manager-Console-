import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:team_console_demo/welcome.dart';

final String domain = "192.168.0.123:3000";

class DeleteTeam extends StatefulWidget {
  DeleteTeam({Key key}) : super(key: key);

  @override
  _DeleteTeamState createState() => _DeleteTeamState();
}

class _DeleteTeamState extends State<DeleteTeam> {
  //*CONNECTION WITH API
  String name_text;
  TextEditingController name = TextEditingController();
  bool rememberMe = false;

  Future<http.Response> teamDelete() async {
    Map body = {
      'name': name.text.toString(),
    };
    return http
        .post('http://$domain/teamDelete', body: body)
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
            title: Text('Delete the Team'),
            centerTitle: true,
            backgroundColor: Colors.green[400]),
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
                      MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text('Delete Team'),
                        splashColor: Colors.redAccent,
                        onPressed: () {
                          if (name.text == '') {
                            setState(() {
                              name_text = 'Enter Team Name';
                            });
                          } else {
                            teamDelete();
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
