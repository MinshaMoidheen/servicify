import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicify/constants/colors.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';
class AddReply extends StatefulWidget {
  const AddReply({super.key});

  @override
  State<AddReply> createState() => _AddReplyState();

}

class _AddReplyState extends State<AddReply> {

  final _replyKey = GlobalKey<FormState>();

  TextEditingController _replyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Complaint Reply",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Complaints").
              where("status",isEqualTo:1).
              snapshots(),
              builder: (context,  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if(!snapshot.hasData){
                  // still waiting for data to come
                  return Center(child: CircularProgressIndicator());

                }
                else if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                  // got data from snapshot but it is empty

                  return Center(child: Text("No Data found"));
                }
                else
                  return ListView.builder(

                      itemCount: snapshot.data!.docs.length,

                      itemBuilder: ( BuildContext context,int index) {

                        return Padding(
                          padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 24),
                          child: Container(

                            height: 150,
                            width: 220,
                            decoration: BoxDecoration(
                                color: AppColors.contColor2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: snapshot.data!.docs[index]['replystatus']==0?AppColors.contColor2:Colors.green,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),

                                    child: snapshot.data!.docs[index]['replystatus']==0?Center(child: Text( "Reply Pending",)):
                                    Center(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Reply: ${snapshot.data!.docs[index]['reply']}"),
                                    ))
                                    ,

                                  ),
                                ),
                                snapshot.data!.docs[index]['replystatus']==0?Positioned(
                                    bottom: 50,
                                    right: 20,
                                    child:   IconButton(onPressed: (){

                                      showDialog(context: context, builder: (context){

                                        return AlertDialog(
                                          title: Text( "Feedback Reply",),
                                          backgroundColor: AppColors.primaryColor,
                                          content: Container(
                                            height: 180,
                                            width: MediaQuery.of(context).size.width,
                                            color: AppColors.primaryColor,
                                            child: Form(
                                              key: _replyKey,
                                              child: Column(
                                                children: [

                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Field is mandatory";
                                                      }
                                                    },
                                                    cursorColor: primaryColor,
                                                    controller: _replyController,

                                                    decoration: InputDecoration(

                                                      hintText: "Enter reply here",
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
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (_replyKey.currentState!.validate()) {
                                                          FirebaseFirestore.instance.collection("Complaints").doc(snapshot.data!.docs[index]['id']).update({
                                                            "reply":_replyController.text,
                                                            "replystatus":1
                                                          });
                                                          Navigator.pop(context);

                                                        }
                                                      },

                                                      child: Container(

                                                        child: Center(child: Text("Send Reply",)),
                                                        height: 45,
                                                        width: 250,
                                                      ),
                                                    ),
                                                  )



                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });




                                    }, icon: FaIcon(FontAwesomeIcons.message,color: Colors.white,))):SizedBox(),
                                Positioned(
                                    top: 10,
                                    left: 20,
                                    right: 10,
                                    child: Text(
                                      "Title: ${snapshot.data!.docs[index]['title']}",

                                    )),
                                Positioned(
                                    top: 32,
                                    left: 20,
                                    right: 10,
                                    child: Text(

                                      "${snapshot.data!.docs[index]['description']}",

                                    )),

                              ],
                            ),
                          ),
                        );
                      });
              }
          )
      ),

    );
  }
}
