import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jeetogyanse/exit-popup.dart';

class QuizPage extends StatefulWidget {
  var subId;

  QuizPage({Key? key, this.subId}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List QuestionData = [];
  var i;
  @override
  void initState() {
    super.initState();
    sendsubjectid();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff113162),
        body: Builder(builder: (context) {
          return WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: [
                  SizedBox(height: 50,),
                  Container(
                    height: 250,
                    width: 500,
                    color: Colors.white,

                    child:

                    Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Container(
                        height: 50,
                        width: 500,
                        color: Colors.white,
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),SizedBox(height: 20,),
                      Container(
                        height: 50,
                        width: 500,
                        color: Colors.white,
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),SizedBox(height: 20,),
                      Container(
                        height: 50,
                        width: 500,
                        color: Colors.white,
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),SizedBox(height: 20,),
                      Container(
                        height: 50,
                        width: 500,
                        color: Colors.white,
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          child: Text(
                            "Skip",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                )),
                          ),
                        ),
                      ),
                    ],)

                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> sendsubjectid() async {
    print(
        '--------------------------------------Sending Subject Id----------------------------------------------------');
    var apiUrl = "http://192.168.1.68:8080/question";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "sub_id": widget.subId,
      }),
    );

    debugPrint("post response statuscode=======>${response.statusCode}");
    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      QuestionData = json.decode(response.body);
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
