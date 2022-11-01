import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jeetogyanse/quiz-exit-popup.dart';
import 'package:jeetogyanse/your-score-list.dart';
import 'package:timer_count_down/timer_count_down.dart';

class QuizPage extends StatefulWidget {
  var subId;

  QuizPage({Key? key, this.subId}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List QuestionData = [];
  var ResultData;
  var index = 0;
  var count = 1;
  Color _colorContainerone = Colors.white;
  Color _colorContainertwo = Colors.white;
  Color _colorContainerthree = Colors.white;
  Color _colorContainerfour = Colors.white;
  var _selectedIndex = 0;
  var answerone = "";
  var answertwo = "";
  var answerthree = "";
  var answerfour = "";
  var answerfive = "";

  var value;

  bool _loading = true;

  var question1_id;
  var question2_id;
  var question3_id;
  var question4_id;
  var question5_id;
  var answer1;
  var answer2;
  var answer3;
  var answer4;
  var answer5;

  var start_test_time;
  var end_test_time;
  var anstime;
  var contest_time;

  var ans_in_seconds;
  var score;
  var result_id;

  @override
  void initState() {
    start_test_time = DateTime.now().millisecondsSinceEpoch;
    contest_time = DateTime.now().millisecondsSinceEpoch;
    value = "";
    super.initState();
    sendsubjectid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff113162),
      body: WillPopScope(
        onWillPop: () => showQuizExitPopup(context),
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: QuestionData == null || QuestionData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 70,
                          color: Colors.white,
                          child: Countdown(
                            seconds: 1000,
                            build: (BuildContext context, double time) =>
                                Center(
                                    child: Text(time.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                            interval: Duration(milliseconds: 100),
                            onFinished: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => YourScoreListPage()));
                              print('Timer is done!');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            color: Colors.white,
                            height: 200,
                            width: 500,
                            child: Center(
                              child: Text("${QuestionData[index]['questions']}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Ink(
                              child: InkWell(
                                child: Container(
                                    color: _colorContainerone,
                                    height: 40,
                                    width: 500,
                                    child: Text(
                                        "(A)${QuestionData[index]['option1']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                onTap: () {
                                  setState(() {
                                    _colorContainerone == Colors.tealAccent
                                        ? _colorContainerone = Colors.white
                                        : _colorContainerone =
                                            Colors.tealAccent;
                                    _colorContainertwo = Colors.white;
                                    _colorContainerthree = Colors.white;
                                    _colorContainerfour = Colors.white;
                                  });
                                  value = QuestionData[index]['option1'];
                                  print(value);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Ink(
                              child: InkWell(
                                child: Container(
                                    color: _colorContainertwo,
                                    height: 40,
                                    width: 500,
                                    child: Text(
                                        "(B)${QuestionData[index]['option2']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                onTap: () {
                                  setState(() {
                                    _colorContainertwo == Colors.tealAccent
                                        ? _colorContainertwo = Colors.white
                                        : _colorContainertwo =
                                            Colors.tealAccent;
                                    _colorContainerone = Colors.white;
                                    _colorContainerthree = Colors.white;
                                    _colorContainerfour = Colors.white;
                                  });
                                  value = QuestionData[index]['option2'];
                                  print(value);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Ink(
                              child: InkWell(
                                child: Container(
                                    color: _colorContainerthree,
                                    height: 40,
                                    width: 500,
                                    child: Text(
                                        "(C) ${QuestionData[index]['option3']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                onTap: () {
                                  setState(() {
                                    _colorContainerthree == Colors.tealAccent
                                        ? _colorContainerthree = Colors.white
                                        : _colorContainerthree =
                                            Colors.tealAccent;
                                    _colorContainerone = Colors.white;
                                    _colorContainertwo = Colors.white;
                                    _colorContainerfour = Colors.white;
                                  });
                                  value = QuestionData[index]['option3'];
                                  print(value);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Ink(
                              child: InkWell(
                                child: Container(
                                    color: _colorContainerfour,
                                    height: 40,
                                    width: 500,
                                    child: Text(
                                        "(D)${QuestionData[index]['option4']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20))),
                                onTap: () {
                                  setState(() {
                                    _colorContainerfour == Colors.tealAccent
                                        ? _colorContainerfour = Colors.white
                                        : _colorContainerfour =
                                            Colors.tealAccent;

                                    _colorContainerone = Colors.white;
                                    _colorContainertwo = Colors.white;
                                    _colorContainerthree = Colors.white;
                                  });
                                  value = QuestionData[index]['option4'];
                                  print(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: Text(
                                "Skip",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                _colorContainerone = Colors.white;
                                _colorContainertwo = Colors.white;
                                _colorContainerthree = Colors.white;
                                _colorContainerfour = Colors.white;
                                print("Skip button called");
                                if (count < 5 && index < QuestionData.length) {
                                  skipQuestion();
                                  setState(() {
                                    index++;
                                    count++;
                                  });
                                  print(index);
                                  initState();
                                } else if (count == 5 ||
                                    index == QuestionData.length) {
                                  print("FLUTTERTOAST CALLED");
                                  Fluttertoast.showToast(
                                    msg: "No More Questions", // message
                                    toastLength: Toast.LENGTH_SHORT, // length
                                    gravity: ToastGravity.CENTER, // location
                                    timeInSecForIosWeb: 3, // duration
                                  );
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                _colorContainerone = Colors.white;
                                _colorContainertwo = Colors.white;
                                _colorContainerthree = Colors.white;
                                _colorContainerfour = Colors.white;
                                print("nextbutton called");
                                if (count < 5 && index < QuestionData.length) {
                                  nextQuestion();
                                  setState(() {
                                    index++;
                                    count++;
                                  });
                                  print(index);
                                  initState();
                                } else if (count == 5 ||
                                    index == QuestionData.length) {
                                  print("FLUTTERTOAST CALLED");
                                  Fluttertoast.showToast(
                                    msg: "No More Questions", // message
                                    toastLength: Toast.LENGTH_SHORT, // length
                                    gravity: ToastGravity.CENTER, // location
                                    timeInSecForIosWeb: 3, // duration
                                  );
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                setState(() {
                                  end_test_time =
                                      DateTime.now().millisecondsSinceEpoch;
                                  calculateTime();
                                  print(start_test_time);
                                  print(end_test_time);
                                  print(
                                      "SUBMIT BUTTON IS CALLED -ANSWER IS AS FOLLOWS");

                                  if (index == 4) {
                                    question5_id = QuestionData[4]['_id'];
                                    answer5 = value;
                                    print("Question id==>${question5_id}");
                                    print("answerr===>$answer5");
                                  }
                                  print("First Answer is-${answer1}");
                                  print("Second Answer is-${answer2}");
                                  print("Third Answer is-${answer3}");
                                  print("Forth Answer is-${answer4}");
                                  print("Five Answer is-${answer5}");
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => YourScoreListPage(
                                          subId: widget.subId,
                                          answer1: answer1,
                                          answer2: answer2,
                                          answer3: answer3,
                                          answer4: answer4,
                                          answer5: answer5,
                                          contest_time: contest_time,
                                          ans_in_seconds: ans_in_seconds,
                                        )));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                )),
                              ),
                            ),
                          ],
                        )
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
      setState(() {
        QuestionData = json.decode(response.body);
      });
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

  nextQuestion() {
    print('------------nextQuestion is called by flutter----------');
    if (count < 5 && index < QuestionData.length) {
      if (index == 0) {
        question1_id = QuestionData[0]['_id'];
        answer1 = value;
        print("Question id==>${question1_id}");
        print("answerr===>$answer1");
      } else if (index == 1) {
        question2_id = QuestionData[1]['_id'];
        answer2 = value;
        print("Question id==>${question2_id}");
        print("answerr===>$answer2");
      } else if (index == 2) {
        question3_id = QuestionData[2]['_id'];
        answer3 = value;
        print("Question id==>${question3_id}");
        print("answerr===>$answer3");
      } else if (index == 3) {
        question4_id = QuestionData[3]['_id'];
        answer4 = value;
        print("Question id==>${question4_id}");
        print("answerr===>$answer4");
      } else if (index == 4) {
        question5_id = QuestionData[4]['_id'];
        answer5 = value;
        print("Question id==>${question5_id}");
        print("answerr===>$answer5");
      }
      setState(() {
        //question_id$index=question[index]['_id'];
        index++;
        count++;
      });
      initState();
    }
  }

  skipQuestion() {
    print('------------SKIP---Question is called by flutter----------');
    if (count < 5 && index < QuestionData.length) {
      if (index == 0) {
        question1_id = QuestionData[0]['_id'];
        answer1 = "NOT ANS";
        print("Question id==>${question1_id}");
        print("answerr===>$answer1");
      } else if (index == 1) {
        question2_id = QuestionData[1]['_id'];
        answer2 = "NOT ANS";
        print("Question id==>${question2_id}");
        print("answerr===>$answer2");
      } else if (index == 2) {
        question3_id = QuestionData[2]['_id'];
        answer3 = "NOT ANS";
        print("Question id==>${question3_id}");
        print("answerr===>$answer3");
      } else if (index == 3) {
        question4_id = QuestionData[3]['_id'];
        answer4 = "NOT ANS";
        print("Question id==>${question4_id}");
        print("answerr===>$answer4");
      } else if (index == 4) {
        question5_id = QuestionData[4]['_id'];
        answer5 = "NOT ANS";
        print("Question id==>${question5_id}");
        print("answerr===>$answer5");
      }
      setState(() {
        //question_id$index=question[index]['_id'];
        index++;
        count++;
      });
      initState();
    }
  }

  calculateTime() {
    anstime = end_test_time - start_test_time;
    ans_in_seconds = (anstime / 1000) % 60;
    print("CONTEST TEST TIME IS=${contest_time}");
    print(
        "TIME TAKEN TO ANSWER THE TEST IS IN MILISECOND FORMAT IS=${anstime}");
    print(
        "TIME TAKEN TO ANSWER THE TEST IS IN-SECOND FORMAT IS=${ans_in_seconds}");
  }
}
