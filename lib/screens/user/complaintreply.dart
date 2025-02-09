import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';

import '../../constants/colors.dart';
class ComplaintReply extends StatefulWidget {
  var createdid;
  var createdby;
  ComplaintReply({super.key,this.createdby,this.createdid});

  @override
  State<ComplaintReply> createState() => _ComplaintReplyState();
}

class _ComplaintReplyState extends State<ComplaintReply> {
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
              where("status",isEqualTo:1).where('createdid',isEqualTo: widget.createdid).
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
                                        color: snapshot.data!.docs[index]['replystatus']==1?AppColors.contColor2:Colors.green,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),

                                    child: snapshot.data!.docs[index]['replystatus']==0?
                                    Center(child: Text("Reply Pending",)):
                                    Center(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Reply: ${snapshot.data!.docs[index]['reply']}"),
                                    ))
                                    ,

                                  ),
                                ),
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
