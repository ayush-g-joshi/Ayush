import 'package:flutter/material.dart';
import 'package:jeetogyanse/loginpage.dart';
import 'package:jeetogyanse/logsigpage.dart';
import 'package:jeetogyanse/main.dart';
import 'package:jeetogyanse/wallet.dart';
import 'package:jeetogyanse/winnerlist.dart';
import 'package:jeetogyanse/startcontest.dart';
import 'package:jeetogyanse/gamerules.dart';
import 'package:jeetogyanse/exit-popup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeetogyanse/privacy-policy.dart';
import 'package:jeetogyanse/view-profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeetogyanse/your-score-list.dart';
import 'package:jeetogyanse/homepage.dart';
import 'package:jeetogyanse/startcontest.dart';
import 'package:jeetogyanse/morepage.dart';
class MenuPage extends StatefulWidget {

  const MenuPage ({Key? key}) : super(key: key);

  @override
  State<MenuPage > createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var screens= [StartContestPage(),WinnerListPage(),WalletListPage(),MorePage()];
  var _currentIndex =0;
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Scaffold(

        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff113162)),
          elevation: 0,
          centerTitle: true,
            backgroundColor: Colors.white,
          title: Text("Jeeto-Gyanse",style: TextStyle(fontSize: 30,color: Color(0xff113162),fontWeight: FontWeight.w900,),),
          automaticallyImplyLeading: false,
        ),
      backgroundColor:Colors.white,

        body:Builder(
          builder: (context) {
            return screens[_currentIndex];
          }
        ),
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar_rounded),
              label: 'Winner-List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              label: 'More',
            ),

          ],
          selectedItemColor: Color(0xff113162),
          onTap: (index) => setState(() { _currentIndex = index; },),
        ),

      ),

    );
  }
}

