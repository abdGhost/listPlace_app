import 'package:flutter/material.dart';
import 'package:login_list_of_places/login_api_service.dart';
import 'package:login_list_of_places/screens/list_screen.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final emailText = TextEditingController();
  // final passwordText = TextEditingController();
  String password = '';
  String email = '';
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState.validate()) {
      callLoginApi();
    }
  }

  callLoginApi() {
    final service = LoginApiServices();

    service.apiCallLogin(
      {
        "password": password,
        "username": email,
      },
    ).then((value) async {
      if (value.error == 'failed') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Wrong Email or Password',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ))
            ],
          ),
        );
      } else if (value.token != null) {
        await Future.delayed(Duration(seconds: 1));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListPlaces()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [
              0.2,
              0.5,
              0.8,
              0.7
            ],
                colors: [
              Colors.blue[50],
              Colors.blue[100],
              Colors.blue[200],
              Colors.blue[300]
            ])),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 60.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.blue,
                      highlightColor: Colors.blueAccent,
                      child: const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      if (!text.contains("@")) {
                        return 'Enter Valid email';
                      }
                      return null;
                    },
                    onChanged: (text) => setState(() => email = text),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock_clock_outlined),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      if (text.length < 3) {
                        return 'Enter Valid password';
                      }
                      return null;
                    },
                    onChanged: (text) => setState(() => password = text),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
