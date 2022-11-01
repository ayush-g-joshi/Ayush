import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jeetogyanse/exit-popup.dart';
import 'package:jeetogyanse/loginpage.dart';
import 'package:jeetogyanse/gamerules.dart';
import 'package:jeetogyanse/privacy-policy.dart';
import 'package:jeetogyanse/termsandconditionpage.dart';
import 'package:jeetogyanse/update-profile.dart';
import 'package:jeetogyanse/view-profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logout-popup.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String? user_id;
  var firstName;
  var lastName;
  var dateOfBirth;
  var mobile;
  var email;
  var image;
  var profileData;

  @override
  void initState() {
    checkId();
  }

  checkId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString('user_id');
      print(user_id);
      senduserid();
    });
    print("user id is as above--------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () => showExitPopup(context),
          child: Builder(builder: (context) {
            return  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 750,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            // Important: Remove any padding from the ListView.
                            padding: EdgeInsets.zero,

                            children: [
                              SizedBox(height: 10,),
                              profileData == null || profileData.isEmpty
                                  ? Column(
                                    children: [
                                      Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xff113162),
                                        strokeWidth: 5,
                                      )),
                                      SizedBox(height: 5,),
                                      Text("Please Edit Your Profile")
                                    ],
                                  )
                                  :
                              Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 15,height: 20,),
                                      image == null || image.isEmpty
                                          ?  Center(
                                        child: ClipOval(
                                          child: Container(

                                            height: 60,
                                            width: 60,
                                            color: Color(0xff113162),
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                                          :
                                      Center(
                                        child: ClipOval(
                                          child: Container(

                                            height: 60,
                                            width: 60,
                                            color: Color(0xff113162),
                                            child: FittedBox(
                                              child: Image.network('$image'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("$firstName $lastName"),
                                          Text("+91$mobile "),
                                          Text("$email"),
                                        ],
                                      )
                                    ],
                                  )),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.notification_add,
                                  ),
                                  title: const Text('Notification'),
                                  onTap: () {

                                  },
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.image_search_sharp,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Edit Profile'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  UpdateProfilePage()));
                                    },
                                  );
                                }),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),

                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.integration_instructions_outlined,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Game Rules'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => MenuRulesPage()));
                                    },
                                  );
                                }),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(Icons.watch_later_outlined),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Timing'),
                                    onTap: () {
                                      AlertDialog alert = AlertDialog(
                                        title: Text('Timing Of Live Contest?'),
                                        actions: <Widget>[
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("\u2022 10:00-10:30 AM",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Text("\u2022 12:00-12:30 PM",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Text("\u2022 02:00-02:30 PM",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Text("\u2022 04.00-04.30 PM",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                SizedBox(height: 10,),
                                                Text("\u2022 07:00-07:30 PM",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                  );
                                }),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.password_outlined,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Change Password'),
                                    onTap: () {},
                                  );
                                }),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.integration_instructions,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Terms And Condition'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  TermsAndConditionPage()));
                                    },
                                  );
                                }),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.share,
                                  ),
                                  title: const Text('Shareapp'),
                                  onTap: () {

                                  },
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                  title: const Text('FAQ'),
                                  onTap: () {

                                  },
                                ),
                              ),

                              Divider(
                                color: Colors.black38,
                              ),
                              Container(
                                color: Colors.white,
                                child: Builder(builder: (context) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.logout,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                    ),
                                    title: const Text('Logout'),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => LogoutPopupPage()));
                                      checkId();
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          }),
        ));
  }

  Future<void> senduserid() async {
    print(
        '--------------------------------------Sending User Id-FOR VIEW PROFILE PAGE---------------------------------------------------');
    print(user_id);
    var apiUrl = "http://192.168.1.68:8080/user/profile";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "_id": int.parse(user_id!),
      }),
    );

    debugPrint("post response statuscode--------------${response.statusCode}");

    if (response.statusCode == 200) {
      debugPrint("post response body=======>${jsonDecode(response.body)}");
      profileData = json.decode(response.body);
      print(profileData);
      setState(() {
        firstName = profileData["data"]["firstName"];
        lastName = profileData["data"]["lastName"];
        dateOfBirth = profileData["data"]["dateOfBirth"];
        mobile = profileData["data"]["mobile"];
        email = profileData["data"]["email"];
        image = profileData["data"]["image"];
      });
      print(firstName);
      print(lastName);
      print(dateOfBirth);
      print(mobile);
      print(email);
    } else {
      Fluttertoast.showToast(
        msg: json.decode(response.body)["message"], // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1, // duration
      );
      print('error');
    }
  }
}
