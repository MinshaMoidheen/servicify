import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewWorkers extends StatefulWidget {
  var createdid;
  ViewWorkers({super.key,this.createdid});

  @override
  State<ViewWorkers> createState() => _ViewWorkersState();
}

class _ViewWorkersState extends State<ViewWorkers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View Workers",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("workers").
              where("status",isEqualTo: 1).where('createdby',isNotEqualTo: widget.createdid).
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
                            title: Text("Name:${snapshot.data!.docs[index]['name']}"),
                            subtitle: Text("Service:${snapshot.data!.docs[index]['service']}"),
                            trailing: IconButton(onPressed: (){
                              FirebaseFirestore.instance.collection('workers').doc( "${snapshot.data!.docs[index]['id']}").update({
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

