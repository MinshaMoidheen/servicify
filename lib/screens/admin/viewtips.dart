import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewAllTips extends StatefulWidget {
  const ViewAllTips({super.key});

  @override
  State<ViewAllTips> createState() => _ViewAllTipsState();
}

class _ViewAllTipsState extends State<ViewAllTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View Tips",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("tips").
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
                                        Text(snapshot.data!.docs[index]['description']),
                                        SizedBox(height:20,),


                                        SizedBox(height:20,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [

                                            ElevatedButton(

                                                onPressed: (){
                                                  Navigator.pop(context);

                                                }, child: Text("Cancel")),
                                            ElevatedButton(onPressed: (){
                                              FirebaseFirestore.instance.collection('notification').doc( "${snapshot.data!.docs[index]['uid']}").update({
                                                'status':0
                                              });
                                            }, child: Text("Delete")),
                                          ],
                                        )

                                      ],
                                    ),
                                  );
                                });




                              },
                              leading: CircleAvatar(
                                child: Text("${index+1}"),
                              ),
                              title: Text("Title:${snapshot.data!.docs[index]['title']}"),
                              subtitle: Text("Description:${snapshot.data!.docs[index]['description']}"),
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

