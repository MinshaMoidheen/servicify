import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';
class AcceptShopRequest extends StatefulWidget {
  var id;

  AcceptShopRequest({super.key,this.id});

  @override
  State<AcceptShopRequest> createState() => _AcceptShopRequestState();
}

class _AcceptShopRequestState extends State<AcceptShopRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View Requests",
          style: appbarStyle,
        ),
      ),
      body: Container(

          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("appointment").
              where("status",isEqualTo: 1).where('serviceid',isEqualTo:widget.id ).where('bookingstatus',isEqualTo: 1).
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
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length ,
                      itemBuilder: (context, index) {


                        return Padding(
                          padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Colors.black12,
                            ),

                            height: 160,
                            width: 280,

                            child: Stack(
                              children: [
                                Positioned(
                                    left: 20,
                                    top: 20,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 15,
                                      child: Center(
                                          child: Text(
                                            "${index + 1}",

                                          )),
                                    )),
                                Positioned(
                                    top: 25,
                                    left: 60,
                                    right: 10,
                                    child: Text(
                                      "ServiceType: ${snapshot.data!.docs[index]['servicetype']}",

                                    )),

                                Positioned(
                                    top: 65,
                                    left: 60,
                                    right: 10,
                                    child: Text(
                                      "Name: ${snapshot.data!.docs[index]['createdby']}",

                                    )),
                                Positioned(
                                    top: 85,
                                    left: 60,
                                    right: 10,
                                    child: Text(
                                      "Phone: ${snapshot.data!.docs[index]['phone']}",

                                    )),
                                Positioned(
                                    top: 105,
                                    left: 60,
                                    right: 10,
                                    child: Text(
                                      "Location: ${snapshot.data!.docs[index]['location']}",

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
