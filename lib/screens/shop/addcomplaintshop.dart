import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:uuid/uuid.dart';

import '../constants/colors.dart';
class ShopComplaintRegistration extends StatefulWidget {

  var createdby;
  var createdid;
  ShopComplaintRegistration({super.key,this.createdid,this.createdby});

  @override
  State<ShopComplaintRegistration> createState() => _ShopComplaintRegistrationState();
}

class _ShopComplaintRegistrationState extends State<ShopComplaintRegistration> {
  final key=GlobalKey<FormState>();

  var uuid = Uuid();
  var v1;

  @override
  void initState() {
    // TODO: implement initState

    v1 = uuid.v1();
    super.initState();
  }


  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Add Complaints",
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
                  controller: _titleController,

                  decoration: InputDecoration(

                    hintText: "Enter title here",
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

                  controller: _descriptionController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Enter description here",
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

                Center(
                  child: InkWell(
                    onTap: (){

                      if(key.currentState!.validate()){
                        FirebaseFirestore.instance
                            .collection("Complaints")
                            .doc(v1)
                            .set({
                          "title": _titleController.text,
                          "description": _descriptionController.text,
                          'reply':"",
                          'replystatus':0,

                          "status": 1,
                          "id": v1,
                          "createdDate": DateTime.now(),
                          'createdby':widget.createdby,
                          'createdid':widget.createdid
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.lightGreen,
                              content: Text("Send Succesfully")));
                          Navigator.pop(context);
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

                          child: Text("Send",style: GoogleFonts.robotoSlab(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)


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
