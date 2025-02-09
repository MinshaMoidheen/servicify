import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class BatteryPage extends StatefulWidget {

  var createdby;
  var createdid;
  var location;
  var phone;
  BatteryPage({super.key,this.createdid,this.createdby,this.phone,this.location});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var v1;
  var uuid = Uuid();


  @override
  void initState() {
    super.initState();
    v1 = uuid.v1();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Battery replacement",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("mobileservices").
              where("status",isEqualTo:1).
              where('servicetype',isEqualTo: 'Battery replacement').
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
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),

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
                                        Text("Name:${snapshot.data!.docs[index]['createdby']}"),
                                        SizedBox(height:20,),
                                        Text("Phone No:${snapshot.data!.docs[index]['phone']}"),
                                        SizedBox(height:20,),

                                        Text("Cost:${snapshot.data!.docs[index]['cost']}"),
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
                                              FirebaseFirestore.instance.collection("appointment")
                                                  .doc(v1).

                                              set({
                                                'phone':widget.phone,
                                                'location':widget.location,

                                                'createdby':widget.createdby,
                                                'createdid':widget.createdid,
                                                'bookingstatus':0,
                                                'servicetype':'Battery replacement',
                                                'serviceby':snapshot.data!.docs[index]['createdby'],
                                                'serviceid':snapshot.data!.docs[index]['createdid'],
                                                'title':snapshot.data!.docs[index]['title'],
                                                "status": 1,
                                                "id":v1,
                                                "createdDate": DateTime.now(),

                                              })
                                                  .then((value) { showsnackbar(" Appointment Added Succesfully !");
                                              Navigator.pop(context);}
                                              );
                                            }, child: Text("Book now")),
                                          ],
                                        )

                                      ],
                                    ),
                                  );
                                });




                              },


                              leading: CircleAvatar(
                                radius: 50,
                                child: Text("${index+1}"),
                              ),
                              title: Text("Name:${snapshot.data!.docs[index]['createdby']}"),
                              subtitle: Text("Phone No:${snapshot.data!.docs[index]['phone']}"),
                              trailing: IconButton(
                                onPressed:
                                    (){
                                  _makePhoneCall(snapshot.data!.docs[index]['phone']);


                                },
                                icon: Icon(Icons.phone),
                              ),

                            ),
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
  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value))
    );
  }

}

