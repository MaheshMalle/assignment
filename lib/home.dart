import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:settyl_assignment/map.dart';

class Home extends StatefulWidget {
  final String email;
  final String address;
  final String uid;
  final String phone;
  final String name;
  Home(
      {Key? key,
      required this.email,
      required this.address,
      required this.uid,
      required this.phone,
      required this.name})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final updateNamecontroller = TextEditingController();
  final updateNumbercontroller = TextEditingController();

  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }


  

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateNamecontroller.text = widget.name;
    updateNumbercontroller.text = widget.phone;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Personal Details'),
            Tab(text: 'Location'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.email),
                  subtitle: Text('email'),
                ),
                ListTile(
                  title: Text(updateNamecontroller.text),
                  subtitle: Text('Name'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to another screen to change details
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                title: Text("Update"),
                                content: TextFormField(
                                  controller: updateNamecontroller,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        setState(() {
                                          dbRef.child(widget.uid).update({
                                            'name': updateNamecontroller.text
                                                .toString(),
                                          });
                                        });

                                        //updatecontroller.text = '';
                                      },
                                      child: Text("Update")),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
                ListTile(
                  title: Text(updateNumbercontroller.text),
                  subtitle: Text('Phone Number'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to another screen to change details
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                title: Text("Update"),
                                content: TextFormField(
                                  controller: updateNumbercontroller,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        setState(() {
                                          dbRef.child(widget.uid).update({
                                            'phone': updateNumbercontroller.text
                                                .toString(),
                                          });
                                        });

                                        //updatecontroller.text = '';
                                      },
                                      child: Text("Update")),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(child: ElevatedButton(onPressed: () { 
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ),
                            );
           },
          child: Text("Go to map")),)
        ],
      ),
    );
  }
}
