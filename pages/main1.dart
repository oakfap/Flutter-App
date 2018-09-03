import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../struct/user.dart';

String email,password,stationid,key;
int money;
String hostemail,Sid;


class UserDetail extends StatelessWidget
{
  UserDetail(String e,String p,int m,String sid,String k)
  {
    email=e; password=p; money=m; stationid=sid; key=k;
  }
  @override
  Widget build( BuildContext context) {
    return new MaterialApp(
      title: 'Account Manager',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange,accentColor: Colors.black
      ),
      home: new MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
int m1,realmoney;
class _MyHomePageState extends State<MyHomePage> {

  initState()
  {
    realmoney=money;
    print(realmoney);
    super.initState();
  }

  List<User> putuserlist=[];
  void putdatas() {
    setState(() {
    money=5;
    final Map<String,dynamic> userd =
    {
      'money': realmoney,
      'email': email,
      'password': password,
      'StationId': stationid
    };
    http.put('https://oakfap222.firebaseio.com/User/'+key+'.json', body: json.encode(userd))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final User newProduct = User(
          id : responseData['id'],
          money: responseData['money'],
          email: responseData['email'],
          password: responseData['password'],
          stationid: responseData['StationId']
      );
      putuserlist.add(newProduct);
      print(newProduct);
    });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Account Manager'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text('Hello '+email+'!'),
            new Text('Your Balance :: '+  realmoney.toString()),
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
                  setState((){
                    m1=int.parse(txt);
                  print(m1);
                });}))),
            new Text('')
            ,
            new RaisedButton (child: new Text('Buy'),
                onPressed: (){
                realmoney-=m1;
                print(money);
              putdatas();
              }
            ),
            new Center(child:new Text('Host Station ID ')),
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
                    )))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
