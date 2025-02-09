import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewAllFrelancers extends StatefulWidget {
  const ViewAllFrelancers({super.key});

  @override
  State<ViewAllFrelancers> createState() => _ViewAllFrelancersState();
}

class _ViewAllFrelancersState extends State<ViewAllFrelancers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View All Freelancers",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("freelancer").
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
                                  padding: EdgeInsets.all(20),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,


                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text("Name:${snapshot.data!.docs[index]['name']}"),
                                      Text("Email:${snapshot.data!.docs[index]['email']}"),
                                      Text("Phone:${snapshot.data!.docs[index]['phone']}"),
                                      Text("ServiceType:${snapshot.data!.docs[index]['services']}"),
                                      Text("City:${snapshot.data!.docs[index]['location']}"),
                                      Text("Category:${snapshot.data!.docs[index]['category']}"),

                                    ],
                                  ),
                                );
                              });




                            },
                            leading: CircleAvatar(
                              child: Text("${index+1}"),
                            ),
                            title: Text("Name:${snapshot.data!.docs[index]['name']}"),
                            subtitle: Text("Email:${snapshot.data!.docs[index]['email']}"),
                            trailing: IconButton(onPressed: (){
                              FirebaseFirestore.instance.collection('freelancer').doc( "${snapshot.data!.docs[index]['uid']}").update({
                                'status':0
                              });
                            },
                            icon: Icon(Icons.delete),),

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

