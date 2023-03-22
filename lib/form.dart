import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:settyl_assignment/home.dart';
import 'package:firebase_database/firebase_database.dart';

class form extends StatefulWidget {
  final String email;
  const form({super.key, required this.email});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final formKey = GlobalKey<FormState>(); //key for form
  final NameController = TextEditingController();
  final addressController = TextEditingController();
  final PhNoController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  "Here to Get",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                Text(
                  "Welcomed !",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: NameController,
                  decoration: InputDecoration(labelText: "Enter Your Name"),
                  // validator: (value) {
                  //   if (value!.isEmpty ||
                  //       RegExp(r'[a-z A-Z] + $').hasMatch(value)) {
                  //     return "Enter Correct name";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: PhNoController,
                  decoration:
                      InputDecoration(labelText: "Enter your phone number"),
                  // validator: (value) {
                  //   if (value!.isEmpty ||
                  //       RegExp(r'[a-z A-Z] + $').hasMatch(value)) {
                  //     return "Enter Correct name";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Enter Your address"),
                  // validator: (value) {
                  //   if (value!.isEmpty ||
                  //       RegExp(r'[a-z A-Z] + $').hasMatch(value)) {
                  //     return "Enter Correct name";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        String id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        ref.child(id).set({
                          'name': NameController.text.toString(),
                          'email': widget.email,
                          'phone': PhNoController.text.toString(),
                          'id': id,
                          'address': addressController.text.toString(),
                        }).then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(email: widget.email,address: addressController.text.toString(),uid: id,phone: PhNoController.text.toString(), name: NameController.text.toString(),),
                            ),
                          );
                        }).catchError((error) {
                          Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFF363f93),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
