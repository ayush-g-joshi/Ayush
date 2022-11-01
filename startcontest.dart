import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jeetogyanse/exit-popup.dart';
import 'package:jeetogyanse/quiz.dart';
import 'package:jeetogyanse/wrong-time.dart';

class StartContestPage extends StatefulWidget {
  const StartContestPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StartContestPage> createState() => _StartContestPageState();
}

class _StartContestPageState extends State<StartContestPage> {
  List homePageData = [];
  var subId;

  @override
  void initState() {
    getSubject();
  }

  @override
  Widget build(BuildContext context) {
    return homePageData == null || homePageData.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            color:  Color(0xff113162),
            strokeWidth: 5,
          ))
        : WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: homePageData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Container(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  "${homePageData[index]['image']}",
                                  fit: BoxFit.fill,
                                )),
                            title: Text("${homePageData[index]['sub']}",
                                style: TextStyle(color: Colors.black)),
                            onTap: () {
                              final subId = homePageData[index]['_id'];
                              print("Subject id number is---------${subId}");


                                startContestone(subId);
                                startContestwo(subId);
                              startContesthree(subId);
                              startContestfour(subId);
                              startContestfive(subId);

                            },
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }

  getSubject() async {
    print(
        '-------------------------------------------------API INTEGRATION For Subject ListSTARTED---------------------------------------------------------');
    final response = await http.get(Uri.parse('http://192.168.1.68:8080/home'));
    if (response.statusCode == 200) {

      debugPrint("Show Responce=${json.decode(response.body)}");
      setState(() {
        homePageData = json.decode(response.body);
      });
    } else {
      print(
          '-------------------------------------------------Failed-----------------------------------------------------------');
    }
  }

  startContestone(subId) async {
    //Tocalculate current date
    print("WE ARE CALLING Current Date");
    var currentTime = DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayDate= formatter.format(now);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print("WE ARE CALLING STARTCONTEST_ONE METHOD");
    formattedDate = formatter.format(now);
    print(formattedDate);


    var startTime = "$formattedDate 10:00:00";
    var format1 = DateFormat('yyyy-MM-dd HH:mm:ss');
    var startTimeWithDate = format1.parse(startTime);
    print(startTimeWithDate);


    var endTime = "$formattedDate 10:30:00";
    var endTimeWithDate = format1.parse(endTime);
    print(endTimeWithDate);


    print(currentTime);
    if (currentTime.isAfter(startTimeWithDate) && currentTime.isBefore(endTimeWithDate)) {

       setState(() {
         Navigator.of(context).push(MaterialPageRoute(
             builder: (_) => QuizPage(
               subId: subId,

             )));
       });
       print(subId);
    } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => WrongTimePage()));
      };
  }

  startContestwo(subId) async {
    //Tocalculate current date
    print("WE ARE CALLING Current Date");
    var currentTime = DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayDate= formatter.format(now);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print("WE ARE CALLING STARTCONTEST_ONE METHOD");
    formattedDate = formatter.format(now);
    print(formattedDate);


    var startTime = "$formattedDate 12:00:00";
    var format1 = DateFormat('yyyy-MM-dd HH:mm:ss');
    var startTimeWithDate = format1.parse(startTime);
    print(startTimeWithDate);


    var endTime = "$formattedDate 12:30:00";
    var endTimeWithDate = format1.parse(endTime);
    print(endTimeWithDate);


    print(currentTime);
    if (currentTime.isAfter(startTimeWithDate) && currentTime.isBefore(endTimeWithDate)) {

      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => QuizPage(
              subId: subId,

            )));
      });
      print(subId);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WrongTimePage()));
    };
  }


  startContesthree(subId) async {
    //Tocalculate current date
    print("WE ARE CALLING Current Date");
    var currentTime = DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayDate= formatter.format(now);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print("WE ARE CALLING STARTCONTEST_ONE METHOD");
    formattedDate = formatter.format(now);
    print(formattedDate);


    var startTime = "$formattedDate 14:00:00";
    var format1 = DateFormat('yyyy-MM-dd HH:mm:ss');
    var startTimeWithDate = format1.parse(startTime);
    print(startTimeWithDate);


    var endTime = "$formattedDate 14:30:00";
    var endTimeWithDate = format1.parse(endTime);
    print(endTimeWithDate);


    print(currentTime);
    if (currentTime.isAfter(startTimeWithDate) && currentTime.isBefore(endTimeWithDate)) {

      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => QuizPage(
              subId: subId,

            )));
      });
      print(subId);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WrongTimePage()));
    };
  }


  startContestfour(subId) async {
    //Tocalculate current date
    print("WE ARE CALLING Current Date");
    var currentTime = DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayDate= formatter.format(now);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print("WE ARE CALLING STARTCONTEST_ONE METHOD");
    formattedDate = formatter.format(now);
    print(formattedDate);


    var startTime = "$formattedDate 16:00:00";
    var format1 = DateFormat('yyyy-MM-dd HH:mm:ss');
    var startTimeWithDate = format1.parse(startTime);
    print(startTimeWithDate);


    var endTime = "$formattedDate 16:30:00";
    var endTimeWithDate = format1.parse(endTime);
    print(endTimeWithDate);


    print(currentTime);
    if (currentTime.isAfter(startTimeWithDate) && currentTime.isBefore(endTimeWithDate)) {

      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => QuizPage(
              subId: subId,

            )));
      });
      print(subId);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WrongTimePage()));
    };
  }

  startContestfive(subId) async {
    //Tocalculate current date
    print("WE ARE CALLING Current Date");
    var currentTime = DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayDate= formatter.format(now);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print("WE ARE CALLING STARTCONTEST_ONE METHOD");
    formattedDate = formatter.format(now);
    print(formattedDate);


    var startTime = "$formattedDate 16:00:00";
    var format1 = DateFormat('yyyy-MM-dd HH:mm:ss');
    var startTimeWithDate = format1.parse(startTime);
    print(startTimeWithDate);


    var endTime = "$formattedDate 17:30:00";
    var endTimeWithDate = format1.parse(endTime);
    print(endTimeWithDate);


    print(currentTime);
    if (currentTime.isAfter(startTimeWithDate) && currentTime.isBefore(endTimeWithDate)) {

      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => QuizPage(
              subId: subId,

            )));
      });
      print(subId);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WrongTimePage()));
    };
  }

}
