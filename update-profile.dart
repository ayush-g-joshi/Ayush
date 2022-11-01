import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jeetogyanse/menupage.dart';
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
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(///
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

SizedBox(height: 50,),
                _imagefile==null ?
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 50,),
                ClipOval(
                child:Container(
                  height: 200,
                  width: 200,
                  color: Color(0xff113162,
                )

                )
                ),
                IconButton(
                  onPressed: () async {
                    _pickFromGallery();
                  },
                  icon: Icon(Icons.edit),
                  color: Color(0xff113162),
                ),
              ],
          ):

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

                            icon: Icon(Icons.edit,size: 30),
                            color: Color(0xff113162),
                          ),

                        ],
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first name',
                      labelText: 'FirstName',

                    ),
                    controller: _firstNameController,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your last name',
                      labelText: 'LastName',

                    ),
                    controller: _lastNameController,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                    readOnly: true,
                    controller: dateinput,
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
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.info_outline),
                      hintText: 'About',
                      labelText: 'About',

                    ),
                    controller: _aboutController,
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

    );
  }

  updateProfile() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.1.68:8080/user/update'));
    request.fields.addAll({
      'firstName': _firstNameController.text.trim().toString(),
      'lastName': _lastNameController.text.trim().toString(),
      'dateOfBirth': dateinput.text.trim().toString(),
      'about': _aboutController.text.trim().toString(),
      '_id': user_id!,
    });
    request.files.add(await http.MultipartFile.fromPath('image', "$filepath"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MenuPage()));
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  _pickFromGallery() async {
    PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _imagefile = File(image!.path);
      print("Image picker file path - ${image.path}");
      filepath = image.path;
      print("Final File PATH IS - ${filepath}");
    });
  }
}
