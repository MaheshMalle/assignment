import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:settyl_assignment/Guest.dart';
import 'package:settyl_assignment/Home.dart';
import 'package:settyl_assignment/form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!EmailValidator.validate(value!)) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value!.length < 6) {
                    return "Password must be a minimum of 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // TODO: Implement forgot password functionality
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuestScreen(),
                    ),
                  );
                },
                child: Text(
                  'Skip->',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text.toString(),
                                  password: _passwordController.text.toString())
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => form(email: _emailController.text.toString(),),
                              ),
                            );
                          }).onError((error, stackTrace) {
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          });
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ),
                  Visibility(
                  visible: loading,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.8),
                    child: CircularProgressIndicator(),
                  ),
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
