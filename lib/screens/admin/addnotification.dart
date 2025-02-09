import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:uuid/uuid.dart';

import '../constants/textstyles.dart';


class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {

  TextEditingController _titleController=TextEditingController();
  TextEditingController _msgController=TextEditingController();
  var uuid = Uuid();
  var v1;

  @override
  void initState() {
    // TODO: implement initState

    v1 = uuid.v1();
    super.initState();

  }


  final _notiKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "Add Notification",
          style: appbarStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _notiKey,
          child: Column(
            children: [

              TextFormField(
                controller: _titleController,
                validator: (value){

                  if(value!.isEmpty){

                    return"Title is mandatory";
                  }
                },

                // controller to be added
                decoration: InputDecoration(
                    hintText: "Title"
                ),

              ),

              TextFormField(
                controller: _msgController,
                validator: (value){

                  if(value!.isEmpty){

                    return"Message is mandatory";
                  }
                },

                // controller to be added
                decoration: InputDecoration(
                    hintText: "Message"
                ),

              ),

              SizedBox(height:20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  ElevatedButton(

                      onPressed: (){

                        Navigator.pop(context);

                      }, child: Text("Cancel")),
                  ElevatedButton(onPressed: (){

                    if(_notiKey.currentState!.validate()){

                      FirebaseFirestore.instance.collection("notification")
                          .doc(v1).

                      set({
                        "title": _titleController.text,
                        "message":_msgController.text,
                        "status": 1,
                        "id":v1,
                        "createdDate": DateTime.now(),

                      })
                          .then((value) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.lightGreen,
                          content:
                          Text("Send Succesfully")));
                      Navigator.pop(context);}
                      );
                    }
                  }, child: Text("Send")),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
