import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/custombutton.dart';
import 'package:servicify/screens/constants/customtext.dart';

import '../constants/customtextformfield.dart';


class EditDetails extends StatefulWidget {

  var name;
  var phno;
var location;
  var uid;
  EditDetails({Key? key,this.phno,this.name,this.uid,this.location}) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {

  String? imggurl;
  var _editkey = new GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _locController = TextEditingController();

  @override
  void initState() {
    _nameController.text=widget.name;
    _phController.text=widget.phno;
    _locController.text=widget.location;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Form(
          key:_editkey ,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomText(
                    data: "Update your profile here!!",
                    color: primaryColor,
                    size: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Enter your name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _nameController.clear();
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomTextFormField(
                    controller: _phController,
                    hintText: 'Enter your PhNo',
                    validator: (value) {
                      if (value !.isEmpty ) {
                        return 'Please enter your phno';
                      }
                      return null;
                    },
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _phController.clear();
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomTextFormField(
                    controller: _locController,
                    hintText: 'Enter your Location',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Location';
                      }
                      return null;
                    },
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _locController.clear();
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: 200,
                ),

                // GestureDetector(
                //   onTap: () {
                //     showimage();
                //   },
                //   child: Center(
                //     child: Container(
                //       height: 150,
                //       color: Colors.transparent,
                //       child: _image != null
                //           ? ClipRRect(
                //           child: Image.file(
                //             File(_image!.path),
                //             fit: BoxFit.cover,
                //           ))
                //           : Container(
                //         child: Row(
                //           mainAxisAlignment:
                //           MainAxisAlignment
                //               .center,
                //           children: [
                //             imggurl!.contains(
                //                 "http")
                //                 ? Container(
                //               height: 140,
                //               width: 140,
                //               decoration: BoxDecoration(
                //                   color: AppColors()
                //                       .primaryColor,
                //                   shape: BoxShape
                //                       .circle,
                //                   image: DecorationImage(
                //                       fit: BoxFit
                //                           .cover,
                //                       image: NetworkImage(
                //                           imggurl.toString()))),
                //             )
                //                 : Container(
                //               height: 140,
                //               width: 140,
                //               decoration: BoxDecoration(
                //                   color: AppColors()
                //                       .primaryColor,
                //                   shape: BoxShape
                //                       .circle,
                //                   image: DecorationImage(
                //                       fit: BoxFit
                //                           .cover,
                //                       image: AssetImage(
                //                           imggurl.toString()))),
                //             ),
                //             Icon(
                //               Icons.upload_file,
                //               size: 20,
                //               color: Colors.white,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                CustomButton(
                    height: 30,
                    width: 100,

                    color: primaryColor,
                    onTap: (){
                      if (_editkey.currentState!.validate()) {
                        FirebaseFirestore.instance.collection('users').doc(widget.uid).update({

                          'name': _nameController.text,
                          'location': _locController.text,
                          'phone': _phController.text.trim(),

                        }).then((value)

                        {

                          Navigator.pop(context);
                        }).catchError((e)=>showsnackbar("Registration Failed!"));
                        showsnackbar("Updated Successfully!");

                      }
                    },
                    child:CustomText(
                      data:"Update",
                      color: Colors.white,
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  showsnackbar(String msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.yellowAccent,
        )
    );
  }
}

