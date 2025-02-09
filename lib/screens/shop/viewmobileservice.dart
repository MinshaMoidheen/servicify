import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/shop/mobileservicedetail.dart';


class ViewMobileServices extends StatefulWidget {
  var createdid;
  ViewMobileServices({super.key,this.createdid});

  @override
  State<ViewMobileServices> createState() => _ViewMobileServicesState();
}

class _ViewMobileServicesState extends State<ViewMobileServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View mobile services",
          style: appbarStyle,
        ),
      ),
      body: InkWell(

        child: Container(
            padding: EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            child:StreamBuilder(
                stream: FirebaseFirestore.instance.collection("mobileservices").
                where("status",isEqualTo: 1).where('createdid',isEqualTo: widget.createdid).
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
                              trailing: IconButton(onPressed: (){
                                FirebaseFirestore.instance.collection('mobileservices').doc( "${snapshot.data!.docs[index]['id']}").update({
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
      ),

    );
  }
}

