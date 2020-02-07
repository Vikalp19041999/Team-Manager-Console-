import 'package:flutter/material.dart';
import 'package:team_console_demo/createteam.dart';
import 'package:team_console_demo/createplayer.dart';
import 'package:team_console_demo/deleteplayer.dart';
import 'package:team_console_demo/deleteteam.dart';
import 'package:team_console_demo/viewteam.dart';
import 'package:team_console_demo/viewplayer.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Welcome to Game Console'),
          centerTitle: true,
          backgroundColor: Colors.green[400]),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/player.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "Create Player",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePlayer()));
            },
          ),
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/team.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "Create Team",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeam()));
            },
          ),
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/player.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "Delete Player",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeletePlayer()));
            },
          ),
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/team.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "Delete Team",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteTeam()));
            },
          ),
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/player.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "View Player",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerView()));
            },
          ),
          GestureDetector(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Image.asset('assets/team.png',height: 100, width:100),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Expanded(
                    child: Text(
                      "View Team",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeamView()));
            },
          ),
        ],
      ),
    );
  }
}
