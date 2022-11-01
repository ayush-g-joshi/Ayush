import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeetogyanse/menupage.dart';
import 'package:jeetogyanse/mobilenoforotp.dart';



class OtpVerificationPage extends StatefulWidget {

  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  @override

  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Color(0xff113162)),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Color(0xff113162)),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text("OTP Verification",style: TextStyle(fontSize: 30,color: Color(0xff113162),fontWeight: FontWeight.w900,),),
          ),
          backgroundColor: Colors.white,
          body:Form(

            child: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [

                        Center(
                          child: Text(
                            "Enter The OTP Sent To Your Mobile Number",
                            style: TextStyle(color:Color(0xff113162), fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(

                              prefixIcon: Icon(Icons.pin),
                              hintText: "OTP",
                              filled: true,
                              fillColor: Colors.white,
                            ),

                            controller: _phoneNumberController,
                            validator: (CurrentValue){
                              var nonNullValue=CurrentValue??'';
                              if(nonNullValue.isEmpty){
                                return ("OTP is required");
                              }   else if (nonNullValue.length != 6) {
                                return "Please enter valid OTP number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                            child: Text("RESEND",style: TextStyle(fontSize: 20),),
                            onPressed: (){

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
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            child: Text("Verify And Continue",style: TextStyle(fontSize: 20),),
                            onPressed: (){
                              if(Form.of(context)?.validate()?? false)
                              {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MenuPage()));
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
                  );
                }
            ),
          )
      ),

    );
  }


}

