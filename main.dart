import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'struct/user.dart';
import 'pages/main1.dart';
import 'pages/SignInPage.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build( BuildContext context) {
    return new MaterialApp(
      title: 'Login Page',
      theme: new ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
          primaryColor: Colors.greenAccent,
          accentColor: Colors.black
      ),

      home: new MyHomePage(title: 'Login Page',
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

String e;
String p;
String key;
int m;
class _MyHomePageState extends State<MyHomePage> {

  initState()
  {
    getdatas();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),

      ),
      body:
      new Center(

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
                  textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.black),
                onChanged: (String txt){
                 e=txt;}
            )

           )
        ),

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
               textAlign: TextAlign.center,
               style: new TextStyle(color: Colors.black),
                onChanged: (String txt){
                  p=txt;
                }
            ))),
      new FlatButton(onPressed: ()
      {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signinpages()));
        }
        ,child: new Text('To SingIn')),
        new  Column (children: <Widget>[new RaisedButton (child: new Text('Login'), onPressed: (){
          if(check(e,p)=='true'){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetail(getuserlist[idx].email,getuserlist[idx].password,getuserlist[idx].money,getuserlist[idx].stationid,getuserlist[idx].id))
            );
          };
          
        }),
        new Text('or'),
        new RaisedButton (child: new Text('Fix password'), onPressed: (){putdatas(e,p,m); getdatas();})]),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<User> getuserlist=[];
void getdatas() {
  getuserlist = new List();
  http.get('https://oakfap222.firebaseio.com/User.json')
      .then((http.Response response) {
    final Map<String, dynamic> productListData = json.decode(response.body);
    productListData.forEach((String productId, dynamic productData) {
      final User product = User(
          id: productId,
          money: productData['money'],
          email: productData['email'],
          password: productData['password'],
          stationid: productData['StationId']
       );
      getuserlist.add(product);
      print(product.id);
      print(product.email);
      print(product.money);
      print(product.password);
      print(product.stationid);
    });

  });
}
void putdatas(String e,String p,int money) {
  money=5;
  final Map<String,dynamic> userd =
  {
    'money': money,
    'email': e,
    'password': p
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
    postuserlist.add(newProduct);
    print(newProduct);
  });
}
int idx=0;
String check (String e,String p)
{
  for(var i=0;i<getuserlist.length;i++)
    {
      if(getuserlist[i].email==e&&getuserlist[i].password==p)
        {

          idx=i;
          key=getuserlist[i].id;
          print('true');
          return 'true';
        }
    }
    print('false');
    return 'false';
}