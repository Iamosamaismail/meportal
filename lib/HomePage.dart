import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meportal/main.dart';
import 'dart:async';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:motorapp/LoginPage.dart';

class HomePage extends StatefulWidget {
  final String userid;

  HomePage({required this.userid});

  @override
  _HomePageState createState() => _HomePageState();
}

class User {
  String name;
  String phoneNumber;
  String motor = "";
  String uid = "";
  String pass;
  // final String username;


   User({
    required this.name,
    required this.phoneNumber,
     required this.pass,
     required this.uid,
     required this.motor
  });

  // factory User.fromMap(Map<dynamic, dynamic> map) {
  //   return User(
  //     name: map['name'] ?? '',
  //     phoneNumber: map['contact'] ?? '',
  //     pass: map['pass'] ?? '',
  //     username: map['username'] ?? ''
  //   );
  // }
}


class _HomePageState extends State<HomePage> {
  String mytxt = "";
  String name = "";
  String contact = "";
  String uname = "";
  String pass = "";
  String motornum = "";

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref1 =
      FirebaseDatabase.instance.ref('/users');

  int motorstate = 0;
  int motormode = 0;

  // List<String> titles = ['Sun', 'Moon', 'Star','ssa','sasaa','sasdas','sdasg','ghjh','hhff','dfgdgfd','Sun', 'Moon', 'Star','ssa','sasaa','sasdas','sdasg','ghjh','hhff','dfgdgfd'];
  List<String> titles = [];
  int flow = 0;
  String waterlvl = "0";
  Timer? timer;
  List<String> list = <String>['1', '2', '3', '4', '5'];

  String dropdownValue = "";
  var rng = new Random();

  final List<User> list1 = [];

  Future<void> onstart() async {
    list1.clear();
    var snapshot = await ref1.get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        var motors = value['motors'];
        motors.forEach((mk, myv) {
          list1.add(User(name: value['name'],
              phoneNumber: value['contact'],
              pass: value['pass'],
              uid: key,
              motor: mk));
          print(list1);
        }
        );
        // if(x == 1){
        //   final user = User.fromMap(value);
        //   user.motor = value['m1'];
        //   user.username = key;
        //   list1.add(user);
        // }
        // else if (x ==2){
        //   final user = User.fromMap(value);
        //   user.motor = value['m1'];
        //   user.username = key;
        //   list1.add(user);
        //   final user2 = User.fromMap(value);
        //   user2.motor = value['m2'];
        //   user2.username = key;
        //   list1.add(user2);
        // }
        // else if (x ==3){
        //   final user = User.fromMap(value);
        //   user.motor = value['m1'];
        //   user.username = key;
        //   list1.add(user);
        //   final user2 = User.fromMap(value);
        //   user2.motor = value['m2'];
        //   user2.username = key;
        //   list1.add(user2);
        //   final user3 = User.fromMap(value);
        //   user3.motor = value['m3'];
        //   user3.username = key;
        //   list1.add(user3);
        // }
        // else if (x ==4){
        //   final user = User.fromMap(value);
        //   user.motor = value['m1'];
        //   user.username = key;
        //   list1.add(user);
        //   final user2 = User.fromMap(value);
        //   user2.motor = value['m2'];
        //   user2.username = key;
        //   list1.add(user2);
        //   final user3 = User.fromMap(value);
        //   user3.motor = value['m3'];
        //   user3.username = key;
        //   list1.add(user3);
        //   final user4 = User.fromMap(value);
        //   user4.motor = value['m4'];
        //   user4.username = key;
        //   list1.add(user4);
        // }
        // else if (x ==5){
        //   final user = User.fromMap(value);
        //   user.motor = value['m1'];
        //   user.username = key;
        //   list1.add(user);
        //   final user2 = User.fromMap(value);
        //   user2.motor = value['m2'];
        //   user2.username = key;
        //   list1.add(user2);
        //   final user3 = User.fromMap(value);
        //   user3.motor = value['m3'];
        //   user3.username = key;
        //   list1.add(user3);
        //   final user4 = User.fromMap(value);
        //   user4.motor = value['m4'];
        //   user4.username = key;
        //   list1.add(user4);
        //   final user5 = User.fromMap(value);
        //   user5.motor = value['m5'];
        //   user5.username = key;
        //   list1.add(user5);
        //
        // }

      }
      );
      setState(() {

      });
    }

  }

  @override
  void initState() {
    motornum = list.first;
    onstart();
     // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // titles.add("mymotor");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Create Motor User"),
                  content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: 450,
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.only(top: 10),
                            child: const Text(
                              "Enter Your Personal Details",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 400,
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "    Your Name",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 3),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors
                                                .lightBlue), //<-- SEE HERE
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                  ),
                                ),
                                Divider(),
                                const Text(
                                  "    Contact",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 3),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      // Added this
                                      contentPadding: EdgeInsets.all(8),
                                      // Added this
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors
                                                .lightBlue), //<-- SEE HERE
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        contact = value;
                                      });
                                    },
                                  ),
                                ),
                                Divider(),
                                const Text(
                                  "    User Name",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 3),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors
                                                .lightBlue), //<-- SEE HERE
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        uname = value;
                                      });
                                    },
                                  ),
                                ),
                                Divider(),
                                const Text(
                                  "    Password",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 3),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors
                                                .lightBlue), //<-- SEE HERE
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        pass = value;
                                      });
                                    },
                                  ),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    const Text(
                                      "    No. of Motors ",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                    DropdownButton<String>(
                                      value: motornum,
                                      // icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      // underline: Container(
                                      // height: 2,
                                      // color: Colors.deepPurpleAccent,
                                      // ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          motornum = value!;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        if(name!= "" && uname!="" && contact!=""&& pass!="" ){
                          DatabaseReference ref1 =
                          FirebaseDatabase.instance.ref('/users/$uname');
                          var snapshot = await ref1.get();
                          if (snapshot.exists){
                            showSimpleNotification(const Text("username already exists"),
                                background: Colors.lightBlueAccent);
                          }else{
                            DatabaseReference ref2 =
                            FirebaseDatabase.instance.ref('/users/$uname');
                            await ref2.update({
                              "contact": contact,
                              "name": name,
                              "pass": pass,
                            });
                            DatabaseReference ref3 =
                            FirebaseDatabase.instance.ref('/users/$uname/motors');
                            print(int.parse(motornum));
                            for(int x = 1; x<int.parse(motornum)+1 ; x++){
                              var code = rng.nextInt(900000) + 100000;

                              await ref3.update({
                                "m${code.toString()}": 1,
                              });
                            }
                          }
                          await onstart();
                        }
                        else{
                          showSimpleNotification(const Text("Field should not be null"),
                              background: Colors.lightBlueAccent);
                        }
                        setState(() {
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Create"),
                    )
                    // usually buttons at the bottom of the dialog
                  ],
                );
              },
            );

            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        primary: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Water Motor User List",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const MyStatefulWidget()));
                          },
                          icon: const Icon(Icons.power_settings_new))
                    ],
                  )),
              Container(

                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: ListTile(
                          leading: Text("#"),
                          title: Text("NAME"),
                          trailing: Container(
                            width:  MediaQuery.of(context).size.width/1.5,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width : 100,child: Text("Motor Number")),
                                SizedBox(width : 200, child : Text("Phone Number")),
                                SizedBox(width:100,child: Text("Status")),
                                SizedBox(width : 100,child: Text("Edit")),
                                SizedBox(width:100,child: Text("Delete")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 500,

                      width: MediaQuery.of(context).size.width,

                      child: ListView.builder(
                          itemCount: list1.length,
                          // itemCount: 0,
                          itemBuilder: (context, index) {
                            // final item = titles[index];
                            return Card(

                              child: ListTile(
                                leading: Text("${index+1}"),
                                title: Text(list1[index].name),
                                trailing: Container(
                                  height: 100,
                                  width:  MediaQuery.of(context).size.width/1.25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width: 100,
                                          child: Text("${list1[index].motor}")),
                                      Container(
                                          width: 200,

                                          child: Text("${list1[index].phoneNumber}")),
                                      Container(
                                          width: 100,

                                          child: Text("ACTIVE")),

                                      SizedBox(
                                          width: 100,
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: new Text("Update Motor User"),
                                                    content: StatefulBuilder(
                                                        builder: (BuildContext context, StateSetter setState) {
                                                          return Container(
                                                            height: 450,
                                                            width: 300,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  margin: EdgeInsets.all(10),
                                                                  height: 400,
                                                                  width: 300,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Text(
                                                                        "    Your Name",
                                                                        style: TextStyle(
                                                                            fontSize: 17, color: Colors.black),
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.all(5),
                                                                        margin: const EdgeInsets.only(
                                                                            left: 10, right: 10, top: 3),
                                                                        child: TextField(
                                                                          decoration: const InputDecoration(
                                                                            isDense: true, // Added this
                                                                            contentPadding: EdgeInsets.all(8),
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  width: 1,
                                                                                  color: Colors
                                                                                      .lightBlue), //<-- SEE HERE
                                                                            ),
                                                                          ),
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              name = value;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Divider(),
                                                                      const Text(
                                                                        "    Contact",
                                                                        style: TextStyle(
                                                                            fontSize: 17, color: Colors.black),
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.all(5),
                                                                        margin: const EdgeInsets.only(
                                                                            left: 10, right: 10, top: 3),
                                                                        child: TextField(
                                                                          decoration: const InputDecoration(
                                                                            isDense: true,
                                                                            // Added this
                                                                            contentPadding: EdgeInsets.all(8),
                                                                            // Added this
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  width: 1,
                                                                                  color: Colors
                                                                                      .lightBlue), //<-- SEE HERE
                                                                            ),
                                                                          ),
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              contact = value;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Divider(),
                                                                      // const Text(
                                                                      //   "    User Name",
                                                                      //   style: TextStyle(
                                                                      //       fontSize: 17, color: Colors.black),
                                                                      // ),
                                                                      // Container(
                                                                      //   padding: const EdgeInsets.all(5),
                                                                      //   margin: const EdgeInsets.only(
                                                                      //       left: 10, right: 10, top: 3),
                                                                      //   child: TextField(
                                                                      //     decoration: const InputDecoration(
                                                                      //       isDense: true, // Added this
                                                                      //       contentPadding: EdgeInsets.all(8),
                                                                      //       enabledBorder: OutlineInputBorder(
                                                                      //         borderSide: BorderSide(
                                                                      //             width: 1,
                                                                      //             color: Colors
                                                                      //                 .lightBlue), //<-- SEE HERE
                                                                      //       ),
                                                                      //     ),
                                                                      //     onChanged: (value) {
                                                                      //       setState(() {
                                                                      //         uname = value;
                                                                      //       });
                                                                      //     },
                                                                      //   ),
                                                                      // ),
                                                                      // Divider(),
                                                                      const Text(
                                                                        "    Password",
                                                                        style: TextStyle(
                                                                            fontSize: 17, color: Colors.black),
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.all(5),
                                                                        margin: const EdgeInsets.only(
                                                                            left: 10, right: 10, top: 3),
                                                                        child: TextField(
                                                                          decoration: const InputDecoration(
                                                                            isDense: true, // Added this
                                                                            contentPadding: EdgeInsets.all(8),
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  width: 1,
                                                                                  color: Colors
                                                                                      .lightBlue), //<-- SEE HERE
                                                                            ),
                                                                          ),
                                                                          onChanged: (value) {
                                                                            setState(() {
                                                                              pass = value;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Divider(),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          DatabaseReference ref =
                                                          FirebaseDatabase.instance.ref("users/${list1[index].uid}");
                                                          await ref.update({
                                                            "contact": contact,
                                                            "name": name,
                                                            "pass": pass,
                                                          });
                                                          await onstart();
                                                          setState(() {
                                                            list1[index].name = name;
                                                            list1[index].pass = pass;
                                                            list1[index].phoneNumber = contact;

                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Update"),
                                                      )
                                                      // usually buttons at the bottom of the dialog
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.edit),
                                          )),
                                      SizedBox(
                                          width: 100,

                                          child: IconButton(
                                            onPressed: () async {
                                              DatabaseReference ref4 =
                                              FirebaseDatabase.instance.ref('/users/$uname/motors/${list1[index].motor}');
                                              await ref4.remove();
                                              list1.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.delete),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );

                          }),
                    ),
                  ],
                ),
              )

            ],
          ),
        ));
  }
}
