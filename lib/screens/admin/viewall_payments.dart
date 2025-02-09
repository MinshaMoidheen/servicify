import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllPayments extends StatefulWidget {
  const ViewAllPayments({super.key});

  @override
  State<ViewAllPayments> createState() => _ViewAllPaymentsState();
}

class _ViewAllPaymentsState extends State<ViewAllPayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Payments",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            Expanded(
              child: StreamBuilder(stream: FirebaseFirestore.instance.collection('payments').snapshots(),
                  builder:(context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              
                }
                if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index]['paymenttitle']),
                        subtitle:Text(snapshot.data!.docs[index]['amount'].toString()) ,
                      ),
                    );
                  });
                }
              
                return Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
