import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/user/checkout_page.dart';
import 'package:servicify/screens/user/rating_review.dart';
import 'package:uuid/uuid.dart';

class AcceptedBookings extends StatefulWidget {
  var createdid;
  var createdby;
  AcceptedBookings({super.key, this.createdid,this.createdby});

  @override
  State<AcceptedBookings> createState() => _AcceptedBookingsState();
}

class _AcceptedBookingsState extends State<AcceptedBookings> {


  var v1;
  var uuid = Uuid();




  @override
  void initState() {

    v1 = uuid.v1();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Bookings",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("appointment")
                  .where("status",whereIn: [1,2])
                  .where("bookingstatus", isEqualTo: 1)
                  .where('createdid', isEqualTo: widget.createdid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  // still waiting for data to come
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData &&
                    snapshot.data!.docs.length == 0) {
                  // got data from snapshot but it is empty

                  return Center(child: Text("No Data found"));
                } else
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                TextEditingController _amount =
                                    TextEditingController();
                                TextEditingController _feedback =
                                TextEditingController();
                                final _key = GlobalKey<FormState>();

                                snapshot.data!.docs[index]
                                ['status']==1?  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.all(30),
                                        height: 400,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Form(
                                          key: _key,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              Text(snapshot.data!.docs[index]
                                                  ['servicetype']),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(snapshot.data!.docs[index]
                                                  ['serviceby']),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),



                                              TextFormField(
                                                controller: _amount,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter a valid amount";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                    "Enter Total Amount"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [



                                                  ElevatedButton(
                                                      onPressed: () {
                                                        if (_key.currentState!
                                                            .validate()) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      CheckoutPage(

                                                                        walletid:snapshot.data!.docs[index]
                                                                        ['id'] ,
                                                                          totalPrice:
                                                                              double.parse(_amount.text + ".0"))));
                                                        }
                                                      },
                                                      child: Text("Pay Now"))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }):showDialog(context: context, builder: (context){return

                                    AlertDialog(
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("Cancel"))
                                      ],
                                      content: Container(
                                        height: 100,
                                        child: Center(child: Text("Payment Completed")),
                                      ),
                                    );
                                    });
                              },
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(
                                  "Service:${snapshot.data!.docs[index]['servicetype']}"),
                              trailing: IconButton(onPressed: (){

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingAndReviewPage(

                                          servicerid:snapshot.data!.docs[index]['serviceid'] ,
                                          userid: snapshot.data!.docs[index]['createdid'],
                                          username: snapshot.data!.docs[index]['createdby'],
                                          serviceby:snapshot.data!.docs[index]['serviceby'] ,

                                          id:snapshot.data!.docs[index]['id'] ,
                                        )));

                              },
                              icon: Icon(Icons.send,color: primaryColor,),),

                            ),
                          ));
                    },
                  );
              })),
    );
  }

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value))
    );
  }

}
