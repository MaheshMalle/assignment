import 'package:flutter/material.dart';
import 'package:settyl_assignment/signup.dart';


class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Guest")),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Please sign in to access the application',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                  
                }, child: Text("Go to sign Up screen"))
          ],
        ),
      ),
    );
  }
}
