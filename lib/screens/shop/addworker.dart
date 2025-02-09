import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:uuid/uuid.dart';
class AddWorker extends StatefulWidget {
  var createdby;
  var createdid;
  AddWorker({super.key,this.createdid,this.createdby});

  @override
  State<AddWorker> createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {


  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();

  TextEditingController _phoneController=TextEditingController();
  TextEditingController _expController=TextEditingController();

  List<String>service=[
    'Ram upgrade','chip level'
  ];

  String? selectedservice;
  var uuid = Uuid();
  var v1;

  @override
  void initState() {
    // TODO: implement initState

    v1 = uuid.v1();
    super.initState();
  }



  final key=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "Add User",
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

                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  cursorColor: primaryColor,
                  controller: _nameController,

                  decoration: InputDecoration(

                    hintText: "Name",
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

                  controller: _emailController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Email",
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

                  controller: _phoneController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Phone",
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

                  controller: _expController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Experience",
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



                SizedBox(height: 20,),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(

                    hintText: "Select Service",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                  value: selectedservice,
                  items: service
                      .map((s) => DropdownMenuItem<String>(
                      value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) {

                    selectedservice=value;

                  },
                ),




                SizedBox(height: 20,),

                Center(
                  child: InkWell(
                    onTap: () async{
var id;
                      if(key.currentState!.validate()){

                      await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _phoneController.text).then((value) {
id=value.user!.uid;
                        FirebaseFirestore.instance
                            .collection("workers")
                            .doc(value.user!.uid)
                            .set({
                          "name": _nameController.text,
                          "email": _emailController.text,
                          'phone':_phoneController.text,
                          'experience':_expController.text,
                          'service':selectedservice,
                          "status": 1,
                          "id": value.user!.uid
                          ,
                          "createdDate": DateTime.now(),
                          'createdby':widget.createdby,
                          'createdid':widget.createdid
                        }).then((value) {
                        FirebaseFirestore.instance.collection('login').doc(id).set({

                          "email": _emailController.text,
                          'pass':_phoneController.text,
                          "status": 1,
                          "uid": id,
                          'usertype':"employee",
                          'createdat':DateTime.now()

                        });
                        });
                      });


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

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value))
    );
  }
}
