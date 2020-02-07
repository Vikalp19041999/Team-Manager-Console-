import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_console_demo/login.dart';

final String domain = "192.168.0.123:3000";

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String email_text, pass_text;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool rememberMe = false;

  Future<Null> setRegister() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogin', rememberMe);
  }

  Future<http.Response> Register() async {
    Map body = {'user': email.text.toString(), 'pass': pass.text.toString()};
    return http
        .post('http://$domain/register', body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      print(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Register Yourself'),
        centerTitle:true,
        backgroundColor:Colors.green[400]
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image(
          image: AssetImage('assets/flutter.png'),
          fit: BoxFit.fill,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 50
            ),
            Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                  ))),
              child: Form(
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        onChanged: (a) {
                          email_text = null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        keyboardType: TextInputType.text,
                        controller: pass,
                        onChanged: (a) {
                          pass_text = null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text('Register'),
                        splashColor: Colors.redAccent,
                        onPressed: () {
                          setRegister();
                          if (email.text == '' && pass.text == '') {
                            setState(() {
                              email_text = 'Enter Email';
                              pass_text = 'Enter Password';
                            });
                          } else if (email.text == '') {
                            setState(() {
                              email_text = 'Enter Email';
                            });
                          } else if (pass.text == '') {
                            setState(() {
                              pass_text = 'Enter Password';
                            });
                          } else {
                            Register();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}