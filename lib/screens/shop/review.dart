import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ReviewShop extends StatefulWidget {
  var shopid;
   ReviewShop({super.key,this.shopid});

  @override
  State<ReviewShop> createState() => _ReviewShopState();
}

class _ReviewShopState extends State<ReviewShop> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child:StreamBuilder(
            stream: FirebaseFirestore.instance.collection("reviews").
            where('servicerid',isEqualTo: widget.shopid).
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
                          title: Text("Review msg:${snapshot.data!.docs[index]['comment']}"),
                          subtitle: Text("CreatedBy:${snapshot.data!.docs[index]['username']}"),
                        ),
                      ),
                    );

                  },

                );
            }
        )
    );
  }
}
