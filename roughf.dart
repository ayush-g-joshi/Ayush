import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:jeetogyanse/menupage.dart';
import 'package:jeetogyanse/mobilenoforotp.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  List dataList = List.from([]);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);
  var filepath;
  String? user_id;

  @override
  void initState() {
    super.initState();
  }

  checkId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString('user_id');
      print(user_id);
      updateProfile();
    });
    print("user id is as above--------");
  }
  File? _imagefile;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff113162)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xff113162),
              fontWeight: FontWeight.w900,
            ),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      _pickFromGallery();
                    },
                    icon: Icon(Icons.photo_camera),
                    color: Color(0xff113162),
                  ),

                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      child: Text(
                        "Pick Image From Gallery",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _pickFromGallery();
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff113162)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(0)),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  if (_imagefile != null )
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipOval(
                            child: Image.file(
                              _imagefile!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitWidth,
                            ),
                          ),

                          IconButton(
                            onPressed: () async {
                              _pickFromGallery();
                            },
                            icon: Icon(Icons.photo_camera),
                            color: Color(0xff113162),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xff113162),
                        icon: const Icon(Icons.person,
                            color: Color(0xff113162)),
                        hintText: 'Enter your first name',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "First name",
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      controller: _firstNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xff113162),
                          icon: const Icon(Icons.person,
                              color: Color(0xff113162)),
                          hintText: 'Enter your last name',
                          labelText: "Last name",
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                      controller: _lastNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: dateinput,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff113162),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter Date of Birth",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Date of Birth",
                          filled: true,
                          fillColor: Color(0xff113162),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xff113162),
                          icon: const Icon(Icons.info_outline,
                              color: Color(0xff113162)),
                          hintText: 'About',
                          labelText: "About",
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                      controller: _aboutController,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          checkId();
                        });
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff113162)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  updateProfile() async {


    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.68:8080/user/update'));
    request.fields.addAll({
      'firstName': _firstNameController.text.trim().toString(),
      'lastName':  _lastNameController.text.trim().toString(),
      'dateOfBirth':dateinput.text.trim().toString(),
      'about': _aboutController.text.trim().toString(),
      '_id': user_id!,
    });
    request.files.add(await http.MultipartFile.fromPath('image', "$filepath"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPage()));
      });

    }
    else {
      print(response.reasonPhrase);
    }
  }
  _pickFromGallery() async {

    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _imagefile = File(image!.path);
      print("Image picker file path - ${image.path}");
      filepath=image.path;
      print("Final File PATH IS - ${filepath}");
    });
  }
}