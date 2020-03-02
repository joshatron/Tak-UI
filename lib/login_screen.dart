import 'package:flutter/material.dart';
import 'server.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _serverController = TextEditingController(text: "https://");
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _serverFocus = FocusNode();
  var _loginResult = "";

  _tryLogin() async {
    try {
      var result = await ServerConnection.isAuthenticated(_usernameController.text, _passwordController.text, _serverController.text);
      if(result) {
        setState(() {_loginResult = "";});
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(ServerConnection(_usernameController.text, _passwordController.text, _serverController.text))),
        );
      }
      else {
        setState(() {_loginResult = "Invalid credentials";});
      }
    } catch(err) {
      setState(() {_loginResult = "Error conneting with server";});
    }
  }

  _tryRegister() async {
    try {
      var connection = ServerConnection(_usernameController.text, _passwordController.text, _serverController.text);
      var result = await connection.register();

      if(result) {
        setState(() {_loginResult = "";});
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(connection)),
        );
      }
      else {
        setState(() {_loginResult = "Username taken";});
      }
    } catch(err) {
      setState(() {_loginResult = "Error connecting to server";});
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _serverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login To Server")),
      body: ScrollConfiguration(
          behavior: NoScrollGlowBehavior(),
          child: ListView(
            children: <Widget>[
              Image(image: AssetImage("images/tak.jpg"),),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _usernameController,
                  focusNode: _usernameFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _fieldFocusChange(
                        context, _usernameFocus, _passwordFocus);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _fieldFocusChange(context, _passwordFocus, _serverFocus);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _serverController,
                  focusNode: _serverFocus,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {
                        _tryLogin();
                      },
                      child: Text("Login"),
                    ),
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {
                        _tryRegister();
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    _loginResult,
                    style: TextStyle(color: Colors.red),
                  )
              )
            ],
          )
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
