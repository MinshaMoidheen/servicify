import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/user/lapserviceman.dart';

class AllTips extends StatefulWidget {

  AllTips({super.key, });

  @override
  State<AllTips> createState() => _AllTipsState();
}

class _AllTipsState extends State<AllTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Tips",
          style: appbarStyle,
        ),
      ),
      body: SafeArea(
        child: InkWell(

          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("tips")
                      .where("status", isEqualTo: 1)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      // still waiting for data to come
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.length == 0) {
                      // got data from snapshot but it is empty

                      return Center(child: Text("No Data found"));
                    } else
                      return ListView.builder(
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder: (context,index){
                          return   Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(

                              height: 80,
                              width: MediaQuery.of(context).size.width*0.88,
                              decoration: BoxDecoration(
                                  color:Colors.teal,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: ListTile(
                          leading: CircleAvatar(
                          radius: 20,
                          child: Text("${index+1}"),
                          ),
                                title: Text(snapshot.data!.docs[index]['title'],),
                                subtitle: Text(snapshot.data!.docs[index]['description'],
                            ),
                            )
                          ));

                        },

                      );
                  })),
        ),
      ),
    );
  }
}
