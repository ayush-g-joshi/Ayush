import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeetogyanse/exit-popup.dart';
import 'package:jeetogyanse/exit-popup.dart';

class WinnerListPage extends StatefulWidget {

  const WinnerListPage({Key? key}) : super(key: key);

  @override
  State<WinnerListPage> createState() => _WinnerListPageState();
}

class _WinnerListPageState extends State<WinnerListPage> {

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          backgroundColor: Color(0xff113162),
          body:WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start ,
                        children: [
                          SizedBox(height: 20,),
                          Text("Winner List",style: TextStyle(fontWeight: FontWeight.bold,fontSize:30 ,color: Colors.white)),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  );
                }
            ),
          )
      ),

    );
  }


}

