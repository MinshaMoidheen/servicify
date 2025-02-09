import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewNotifications extends StatefulWidget {
  const ViewNotifications({super.key});

  @override
  State<ViewNotifications> createState() => _ViewNotificationsState();
}

class _ViewNotificationsState extends State<ViewNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        backgroundColor: primaryColor,
        title: Text(
          "View Notifications",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("notification").
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

                              onTap: (){


                                showModalBottomSheet(context: context, builder: (context){



                                  return Container(
                                    padding: EdgeInsets.all(30),
                                    height:350,
                                    width: MediaQuery.of(context).size.width,


                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(snapshot.data!.docs[index]['title']),
                                        SizedBox(height:20,),
                                        Text(snapshot.data!.docs[index]['message']),
                                        SizedBox(height:20,),


                                        SizedBox(height:20,),



                                      ],
                                    ),
                                  );
                                });




                              },
                              leading: CircleAvatar(
                                child: Text("${index+1}"),
                              ),
                              title: Text("Title:${snapshot.data!.docs[index]['title']}"),
                              subtitle: Text("Message:${snapshot.data!.docs[index]['message']}"),
                            ),
                          )
                      );

                    },

                  );
              }
          )
      ),

    );
  }
}

