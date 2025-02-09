
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicify/data/city_list.dart';
import 'package:servicify/screens/admin/admin_home_page.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/service.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';


class AddFreeLapService extends StatefulWidget {
  var createdby;
  var createdid;
  AddFreeLapService({super.key,this.createdby,this.createdid});

  @override
  State<AddFreeLapService> createState() => _AddFreeLapServiceState();
}

class _AddFreeLapServiceState extends State<AddFreeLapService> {


  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptinController=TextEditingController();
  TextEditingController _costController=TextEditingController();
  String?selectedService;
  TextEditingController _phnoController=TextEditingController();

  final key=GlobalKey<FormState>();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  var uuid = Uuid();
  var v1;
  var url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    v1 = uuid.v1();

  }


  @override
  Widget build(BuildContext context) {
    print(widget.createdid);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "Add Services",
          style: appbarStyle,
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,

        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(

                    hintText: "Select Service Type",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                  value: selectedService,
                  items: lapservices
                      .map((item) => DropdownMenuItem<String>(
                      value: item, child: Text(item!)))
                      .toList(),
                  onChanged: (value) {

                    selectedService=value;

                  },
                ),

                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _descriptinController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Desription",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _costController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Cost",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _phnoController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Phone Number",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),


                SizedBox(height: 10,),



                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Upload Photo",
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      showImage();
                    },
                    child: Container(
                      width: 250,
                      height: 250,
                      child: _image!=null?ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                      ):Container(
                        color: Colors.grey,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.grey[100],
                        ),
                      ),
                    ),
                  ),
                ),






                SizedBox(height: 20,),

                Center(
                  child: InkWell(
                    onTap: (){

                      if(key.currentState!.validate()){
                        {
                          var fileExtension = path.extension(_image!.path);
                          print(fileExtension);
                          String fileName =DateTime.now().toString();
                          var ref =
                          FirebaseStorage.instance.ref().child('laps/$fileName');
                          UploadTask uploadTask = ref.putFile(File(_image!.path));


                          uploadTask.then((res) async{
                            url = (await ref.getDownloadURL()).toString();

                          }).then((value) {
                            FirebaseFirestore.instance.collection("lapservices")
                                .doc(v1).

                            set({

                              'description':_descriptinController.text,
                              'cost':_costController.text,
                              'servicetype':selectedService,
                              'phone':_phnoController.text,

                              'bookmarkstatus':0,
                              "status": 1,
                              "id":v1,
                              "createdDate": DateTime.now(),
                              'url':url.toString(),
                              'createdby':widget.createdby,
                              'createdid':widget.createdid
                            })
                                .then((value) { showsnackbar("Succesfully Added!");
                            Navigator.pop(context);}
                            );
                          });

                        }
                      }

                    },
                    child: Container(
                      width: 250,
                      height: 49,

                      decoration: BoxDecoration(
                          color: Color(0xff1F619D),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Center(

                          child: Text("Save",style: GoogleFonts.robotoSlab(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)


                      ),
                    ),
                  ),
                ),






              ],
            ),
          ),
        ),
      ),
    );
  }

  _imagefromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  _imagefromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;

    });
    Navigator.pop(context);
  }

  showImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromCamera();
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                    Text("Camera")
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromGallery();
                        },
                        icon: Icon(Icons.photo),
                      ),
                    ),
                    Text("Gallery")
                  ],
                ),
              ],
            ),
          );
        });
  }

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value))
    );
  }

}

