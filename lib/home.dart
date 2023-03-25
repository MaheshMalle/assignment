import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final addresscontroller = TextEditingController();

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

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
    addresscontroller.text = "chennai";

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
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {}, child: Text("Conform the address")),
              SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: GoogleMap(
                    //mapType: MapType.normal,
                    //onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(13.067439, 80.237617),
                      zoom: 11.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
