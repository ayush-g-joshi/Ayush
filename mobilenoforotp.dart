import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


import 'package:flutter/cupertino.dart';
import 'package:jeetogyanse/menupage.dart';
import 'package:jeetogyanse/otpverificationpage.dart';



class MobilenoForOTPpage extends StatefulWidget {

  const MobilenoForOTPpage({Key? key}) : super(key: key);

  @override
  State<MobilenoForOTPpage> createState() => _MobilenoForOTPpageState();
}

class _MobilenoForOTPpageState extends State<MobilenoForOTPpage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Color(0xff113162)),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Color(0xff113162)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text("Generate OTP ",style: TextStyle(fontSize: 30,color:  Color(0xff113162),fontWeight: FontWeight.w900,),),
          ),
          backgroundColor: Colors.white,
          body:Form(

            child: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [

                          SizedBox(height: 250,),
                          Center(
                            child: Text(
                              "Enter Your Phone Number",
                              style: TextStyle(color: Color(0xff113162), fontSize: 30,fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: Text(
                              "We Will Send You A four Digit Verification Code",
                              style: TextStyle(color: Color(0xff113162), fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(

                                prefixIcon: Icon(Icons.mobile_friendly),
                                hintText: "Mobile Number",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              controller: _phoneNumberController,
                              validator: (CurrentValue) {
                                var nonNullValue = CurrentValue ?? '';
                                if (nonNullValue.isEmpty) {
                                  return ("Mobile Number is required");
                                }
                                if (!phoneRegex.hasMatch(nonNullValue)) {
                                  return 'Please enter valid phone number';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20,),



                          SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              child: Text("Generate OTP",style: TextStyle(fontSize: 20),),
                              onPressed: (){
                                if(Form.of(context)?.validate()?? false)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OtpVerificationPage()));
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
          )
      ),

    );
  }


}

