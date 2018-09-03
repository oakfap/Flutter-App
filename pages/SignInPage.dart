import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../struct/user.dart';


class Signinpages extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build( BuildContext context) {
    return new MaterialApp(
      title: 'SignIn Page',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        accentColor: Colors.black,
      ),

      home: new MyHomePage(title: 'SignIn Page'),
    );
  }
}
int success = 0;
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
String e;
String p;
String Sid;
class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          children: <Widget>[

            new Center(child:new Text('Email ')),
      new Center(
        child :new Container(
          width: 200.0,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(5.0),
                topRight: const  Radius.circular(5.0),
                bottomLeft:  const  Radius.circular(5.0),
                bottomRight: const  Radius.circular(5.0),)
          ),
          child: new TextField(
              style: new TextStyle(color: Colors.black),
                onChanged: (String txt){
                  e=txt;
                }
            ))),
            new Center(child:new Text('Password ')),
      new Center(
        child :new Container(
          width: 200.0,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(5.0),
                topRight: const  Radius.circular(5.0),
                bottomLeft:  const  Radius.circular(5.0),
                bottomRight: const  Radius.circular(5.0),)
          ),
          child: new TextField(
              style: new TextStyle(color: Colors.black),textAlign: TextAlign.center,
                onChanged: (String txt){
                  p=txt;
                }
            ))),
            new Center(child:new Text('Station ID ')),
      new Center(
        child :new Container(
          width: 200.0,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(5.0),
                topRight: const  Radius.circular(5.0),
                bottomLeft:  const  Radius.circular(5.0),
                bottomRight: const  Radius.circular(5.0),)
          ),
          child:  new TextField( decoration: new InputDecoration(hintText:'Plz Ensure The Station ID or "-" if You dont have any'),
              style: new TextStyle(color: Colors.black),textAlign: TextAlign.center,
                onChanged: (String txt){
                  Sid=txt;
                }
            ))),
            new Text(' ')
            ,
            new RaisedButton (child: new Text('Signin'), onPressed: (){
            setState(() {
              postdatas(e,p,Sid);
            });}),
            new Center( child:
            new Text(success == 1 ? 'Success':'')
              ),
            new Center( child:
            success == 1 ?
            new RaisedButton(child: new Text('back'),onPressed: ()
            {
              Navigator.pop(context);
              success=0;
            }
            ):new Text(''))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<User> postuserlist=[];
void postdatas(String e,String p,String Sid) {
  final Map<String,dynamic> userd =
  {
  'money': 0,
  'email': e,
  'password': p,
  'StationId' : Sid
  };
  http.post('https://oakfap222.firebaseio.com/User.json', body: json.encode(userd))
      .then((http.Response response) {
  final Map<String, dynamic> responseData = json.decode(response.body);
  final User newProduct = User(
  id : responseData['id'],
  stationid : responseData['StationId'],
  money: responseData['money'],
  email: responseData['email'],
  password: responseData['password']
  );
  postuserlist.add(newProduct);
  print(newProduct);

  });
  success=1;
}
