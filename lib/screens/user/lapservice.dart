import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/user/lapserviceman.dart';
import 'package:uuid/uuid.dart';
class LapServices extends StatefulWidget {
  var servicetype;
 var createdby;
 var createdid;
 var phone;
 var location;
   LapServices({super.key,this.servicetype,this.createdby,this.createdid,this.phone,this.location});

  @override
  State<LapServices> createState() => _LapServicesState();
}

class _LapServicesState extends State<LapServices> {

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
          "LapTop Services",
          style: appbarStyle,
        ),
      ),
      body: SafeArea(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LapServiceMan()));
          },
          child:Container(

              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("lapservices").
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
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
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
                                        Text("Service:${snapshot.data!.docs[index]['servicetype']}"),
                                        SizedBox(height:20,),
                                        Text("Servicer:${snapshot.data!.docs[index]['createdby']}"),
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
                                                'servicetype':snapshot.data!.docs[index]['servicetype'],
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
                              child: Center(
                                child: Stack(


                                  children: [
                                    Card(
                                      elevation: 7,
                                      child: Container(
                                        height: 130,
                                        width: MediaQuery.of(context).size.width*0.85,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                        top: 4,
                                        left: 4,
                                        child: Container(
                                          height: 131,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data!.docs[index]['url'],),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        )),
                                    Positioned(
                                      left: 110,
                                      top: 15,
                                      child: Text(snapshot.data!.docs[index]['servicetype'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    ),
                                    Positioned(
                                      left: 160,
                                      top: 50,
                                      child: Text(snapshot.data!.docs[index]['description'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),

                                    Positioned(
                                      left: 220,
                                      bottom: 10,
                                      child: Text("${snapshot.data!.docs[index]['cost']}/-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    )

                                  ],

                                ),
                              ),
                            ),
                          );

                        },

                      );
                  }
              )
          ),
        ),
      ),
    );
  }
  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value))
    );
  }
}
