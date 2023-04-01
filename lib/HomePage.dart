import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meportal/main.dart';
import 'dart:async';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##:##:##:##:##:##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  List<String> mname = ["","","","","",""];
  String mytxt = "";
  String name = "";
  String contact = "";
  String uname = "";
  String pass = "";
  String motornum = "";
  final _formKey = GlobalKey<FormState>();

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref1 =
      FirebaseDatabase.instance.ref('/users');

  int motorstate = 0;
  int motormode = 0;

  List<String> titles = [];
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
        });
      });
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Create Motor User"),
                  content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      child: Container(
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
                                      maxLength: 12,

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
                                      maxLength: 12,

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
                                      maxLength: 12,

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
                                      maxLength: 12,

                                      obscureText: true,
                                      obscuringCharacter: "*",

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
                                  Form(
                                      key: _formKey,

                                      child:Column(
                                    children: [
                                        for(int x = 1; x<=int.parse(motornum);x++)...[
                                        TextFormField(
                                          inputFormatters: [maskFormatter],
                                          validator: (value) {
                                            print(value?.length);
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Motor ID';
                                            }
                                            else if(value.length < 17){
                                              return 'Please enter 12 digits';

                                            }
                                            return null;
                                          },
                                        )
                                      ]
                                    ],
                                  )

                                  ),



                                  // for(int x = 1; x<=int.parse(motornum);x++)...[
                                  //   Container(
                                  //     padding: const EdgeInsets.all(5),
                                  //     margin: const EdgeInsets.only(
                                  //         left: 10, right: 10, top: 3),
                                  //     child: Form(child: TextFormField(
                                  //       key: _formKey,
                                  //       validator: (value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return 'Please enter Motor ID';
                                  //         }
                                  //         if(value.length < 17){
                                  //           return 'Please enter 12 digits';
                                  //
                                  //         }
                                  //         return null;
                                  //       },
                                  //     )),
                                  //
                                  //
                                  //
                                  //     // child: TextField(
                                  //     //   decoration: InputDecoration(
                                  //     //     isDense: true, // Added this
                                  //     //     contentPadding: EdgeInsets.all(8),
                                  //     //     enabledBorder: OutlineInputBorder(
                                  //     //       borderSide: BorderSide(
                                  //     //           width: 1,
                                  //     //           color: Colors
                                  //     //               .lightBlue), //<-- SEE HERE
                                  //     //     ),
                                  //     //     hintText: 'Motor ID $x',
                                  //     //     // border: InputBorder.none,
                                  //     //   ),
                                  //     //   inputFormatters: [maskFormatter],
                                  //     //   maxLength: 17,
                                  //     //
                                  //     //   keyboardType: TextInputType.number,
                                  //     //
                                  //     //   onChanged: (value) {
                                  //     //     setState(() {
                                  //     //       mname[x] = value;
                                  //     //     });
                                  //     //   },
                                  //     // ),
                                  //   ),
                                  //
                                  //   // you can add widget here as well
                                  // ],

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if(name!= "" && uname!="" && contact!=""&& pass!="" ) {
                      DatabaseReference ref1 =
                      FirebaseDatabase.instance.ref('/users/$uname');
                      var snapshot = await ref1.get();
                      if (snapshot.exists) {
                        showSimpleNotification(
                            const Text("username already exists"),
                            background: Colors.lightBlueAccent);
                      } else {
                        DatabaseReference ref2 =
                        FirebaseDatabase.instance.ref('/users/$uname');
                        await ref2.update({
                          "contact": contact,
                          "name": name,
                          "pass": pass,
                        });
                        DatabaseReference ref3 =
                        FirebaseDatabase.instance.ref(
                            '/users/$uname/motors');
                        print(int.parse(motornum));
                        for (int x = 1; x < int.parse(motornum) + 1; x++) {
                          await ref3.update({
                            "${mname[x]}": 1,
                          });
                        }
                      }
                      await onstart();
                    } else{
                      showSimpleNotification(const Text("Field should not be null"),
                          background: Colors.lightBlueAccent);
                    }
                    setState(() {
                    });
                    Navigator.pop(context);
                  }
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
          color: Colors.grey,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  height: 80,
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Water Motor User List",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
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
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: Text("#"),
                          title: Text("NAME"),
                          trailing: Container(
                            width:  MediaQuery.of(context).size.width/1.25,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width : 100,child: Text("Motor Number")),
                                SizedBox(width : 200, child : Text("Phone Number")),
                                SizedBox(width:70,child: Text("Status")),
                                SizedBox(width : 40,child: Text("Edit")),
                                SizedBox(width:40,child: Text("Delete")),
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
                                          width: 70,

                                          child: Text("ACTIVE")),

                                      SizedBox(
                                          width: 40,
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
                                                            height: 275,
                                                            width: 300,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "User ID :  ${list1[index].uid}",
                                                                  style: TextStyle(
                                                                      fontSize: 17, color: Colors.black),
                                                                ),
                                                                Divider(),

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
                                                                    maxLength: 12,

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
                                                                    maxLength: 12,

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
                                                                  "    Password",
                                                                  style: TextStyle(
                                                                      fontSize: 17, color: Colors.black),
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets.all(5),
                                                                  margin: const EdgeInsets.only(
                                                                      left: 10, right: 10, top: 3),
                                                                  child: TextField(
                                                                    maxLength: 12,

                                                                    obscureText: true,
                                                                    obscuringCharacter: "*",

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
                                          width: 40,

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
