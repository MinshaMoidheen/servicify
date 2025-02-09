import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewFeedbacks extends StatefulWidget {
  const ViewFeedbacks({super.key});

  @override
  State<ViewFeedbacks> createState() => _ViewFeedbacksState();
}

class _ViewFeedbacksState extends State<ViewFeedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View All Feedbacks",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("feedback").
              where("status",isEqualTo: 1).
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
                    itemCount:snapshot.data!.docs.length ,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(

                          child: ListTile(

                           
                            leading: CircleAvatar(
                              child: Text("${index+1}"),
                            ),
                            title: Text("Title:${snapshot.data!.docs[index]['title']}"),
                            subtitle: Text("Description:${snapshot.data!.docs[index]['description']}"),


                          ),
                        ),
                      );

                    },

                  );
              }
          )
      ),

    );
  }
}

