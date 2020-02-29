import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tak")
        ),
        body: ScrollConfiguration(
          behavior: NoScrollGlowBehavior(),
          child: ListView(
            children: <Widget>[
              Image(image: AssetImage("images/tak.jpg"),),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {},
                      child: Text("Login"),
                    ),
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {},
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

