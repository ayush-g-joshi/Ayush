import 'package:flutter/material.dart';
import 'package:jeetogyanse/menupage.dart';
import 'package:jeetogyanse/afterResetPageLoginPage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:jeetogyanse/mobilenoforotp.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:jeetogyanse/forgototpverificationpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jeetogyanse/forgototpverificationpage.dart';
import 'package:http/http.dart' as http;
import 'package:jeetogyanse/otpforgotpassword.page.dart';
class ForgotOTPverificationPage extends StatefulWidget {
var email;
   ForgotOTPverificationPage ({Key? key, required String this.email}) : super(key: key);

  @override
  State<ForgotOTPverificationPage  > createState() => _ForgotOTPverificationPageState();
}

class _ForgotOTPverificationPageState extends State<ForgotOTPverificationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController newpassword=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  var _email;
  @override
  void initState() {
    super.initState();
    _email=widget.email;
    print(_email);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Color(0xff113162)),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Color(0xff113162)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text("Reset Your Password",style: TextStyle(fontSize: 30,color: Color(0xff113162),fontWeight: FontWeight.w900,),),
          ),
          body:Padding(
            padding: const EdgeInsets.all(16),
            child: Form(

              child: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            SizedBox(height: 50,),

                            Center(
                              child: Text(
                                "Reset Your Password",
                                style: TextStyle(color: Color(0xff113162), fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                "We Have Send  A Four Digit Verification Code",
                                style: TextStyle(color: Color(0xff113162), fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20,),

                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(

                                prefixIcon: Icon(Icons.pin),
                                hintText: "OTP",
                                labelText: "OTP",
                                filled: true,
                                fillColor: Colors.white,
                              ),

                              controller: _phoneNumberController,
                              validator: (CurrentValue){
                                var nonNullValue=CurrentValue??'';
                                if(nonNullValue.isEmpty){
                                  return ("OTP is required");
                                }   else if (nonNullValue.length != 4) {
                                  return "Please enter valid OTP number";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              decoration: InputDecoration(

                                prefixIcon: Icon(Icons.password_outlined),
                                hintText: "New Password",
                                labelText: "New Password",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: newpassword,
                              validator: (PassCurrentValue){
                                RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                var passNonNullValue=PassCurrentValue??"";
                                if(passNonNullValue.isEmpty){
                                  return ("Password is required");
                                }
                                else if(passNonNullValue.length<6){
                                  return ("Password Must be more than 5 characters");
                                }
                                else if(!regex.hasMatch(passNonNullValue)){
                                  return ("Password should contain upper,lower,digit and Special character ");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              decoration: InputDecoration(

                                prefixIcon: Icon(Icons.password_outlined),
                                hintText: "Confirm Password",
                                labelText: "Confirm Password",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: confirmpassword,
                              validator: (PassCurrentValue){
                                var passNonNullValue=PassCurrentValue??"";
                                if(passNonNullValue.isEmpty){
                                  return ("Password is required");
                                }else if(passNonNullValue != newpassword.text)
                                return ("Both password must be same");
                              },
                            ),

                            SizedBox(height: 20,),
                            SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                child: Text("RESEND",style: TextStyle(fontSize: 20),),
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => OTPForgotPasswordPage()));
                                },
                                style: ButtonStyle(

                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff113162)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),


                            SizedBox(
                              width: 200,
                              height: 40,
                              child: ElevatedButton(
                                child: Text("Reset Password",style: TextStyle(fontSize: 20),),
                                onPressed: (){
                                  if(Form.of(context)?.validate()?? false)
                                  {
                                    verifyOTP();
                                  }
                                },
                                style: ButtonStyle(

                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff113162)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      )
                                  ),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          )
      ),

    );
  }
  verifyOTP() async {
    print('Verify OTP__________________________________________________ called');
    var apiUrl = "http://192.168.1.68:8080/forgot/otp";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "email": _email.trim().toString(),
        "otp": _phoneNumberController.text.trim().toString(),
        "password": confirmpassword.text.trim().toString(),
      }),
    );
    print(response.body);
    debugPrint("post response statuscode=======>${response.statusCode}");
    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AfterRestPassLoginPage()));
      print('success');
      debugPrint(
          "post response body=======>${json.decode(response.body)["data"]}");
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

