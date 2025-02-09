import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/common/login_page.dart';
import 'package:servicify/screens/user/RamUpgrade.dart';
import 'package:servicify/screens/user/batterypage.dart';
import 'package:servicify/screens/user/bodypage.dart';
import 'package:servicify/screens/user/camerapage.dart';
import 'package:servicify/screens/user/displaypage.dart';

import 'package:servicify/screens/user/lapservice.dart';
import 'package:servicify/screens/user/lapserviceman.dart';
import 'package:servicify/screens/user/portpage.dart';
import 'package:servicify/screens/user/softwarepage.dart';
import 'package:servicify/screens/user/speakerpage.dart';
import 'package:servicify/screens/user/tips.dart';
import 'package:servicify/screens/user/waterpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';



class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  var bookmarkstatus=0;
  String? _name;
  String? _email;
  String? _phone;
  String? token;
  String? _location;


  Map<String, dynamic> data = {};
  String? _uid;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = await _pref.getString('token');
    _name = await _pref.getString(
      'name',
    );

    _email = await _pref.getString(
      'email',
    );
    _phone = await _pref.getString(
      'phone',
    );
    _location = await _pref.getString(
      'location',
    );


    _uid = await _pref.getString(
      'uid',
    );


    setState(() {

    });
  }

  var v1;
  var uuid = Uuid();




  @override
  void initState() {

    getData();
    v1 = uuid.v1();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllTips()));

                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 300,bottom: 10),
                  child: Text("See All".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 14),),
                )),
            Container(
                height: 200,
                width: double.infinity,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("tips").
                    where("status",isEqualTo: 1).limit(1).orderBy('createdDate',descending: false).
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
                            return   Container(
                              padding: EdgeInsets.all(20),
                              height: 150,
                              width: MediaQuery.of(context).size.width*0.88,
                              decoration: BoxDecoration(
                                  color:Colors.teal,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [


                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(snapshot.data!.docs[index]['title'],
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                        ),

                                        Expanded(
                                          child: Text(snapshot.data!.docs[index]['description'],
                                            style: TextStyle(fontSize: 15),),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Container(
                                  //     child: Image.asset('assets/img/logo.png'),
                                  //   ),
                                  // )

                                ],
                              ),
                            );

                          },

                        );
                    }
                )
            ),


            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Laptop Services".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)
                ,InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LapServices(

                                createdid: _uid,
                                createdby: _name,
                                phone: _phone,
                                location: _location,
                              )));

                    },
                    child: Text("See All".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 14),))
              ],
            ),
            SizedBox(height: 20,),

            Container(

                height: 350,
                width: double.infinity,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("lapservices").
                    where("status",isEqualTo: 1).limit(2).
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

                                                  'createdby':_name,
                                                  'createdid':_uid,
                                                  'bookingstatus':0,
                                                  'servicetype':snapshot.data!.docs[index]['servicetype'],
                                                  'serviceby':snapshot.data!.docs[index]['createdby'],
                                                  'serviceid':snapshot.data!.docs[index]['createdid'],

                                                  'phone':_phone,
                                                  'location':_location,
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
                                child: Stack(

                                  children: [
                                    Card(
                                      elevation: 7,
                                      child: Container(
                                        height: 130,
                                        width: MediaQuery.of(context).size.width*0.85,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(0xffFBE9E7)
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
                                      top: 5,
                                      right: 10,
                                      child: IconButton(
                                        icon: (snapshot.data!.docs[index]['bookmarkstatus'] == 0)
                                            ? Icon(Icons.bookmark_border)
                                            : Icon(Icons.bookmark),
                                        onPressed: (){
                                          setState(() {
                                            FirebaseFirestore.instance.collection('lapservices').doc(snapshot.data!.docs[index]['id']).update({
                                              'bookmarkstatus':1
                                            });
                                          });
                                        }, // Toggle bookmarkStatus when icon is tapped
                                      ),
                                    ),

                                    Positioned(
                                      left: 110,
                                      top: 35,
                                      child: Text(snapshot.data!.docs[index]['servicetype'],
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    ),

                                    Positioned(
                                      left: 110,
                                      top: 85,
                                      child: Text(snapshot.data!.docs[index]['createdby'],
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    ),

                                    Positioned(
                                      left: 220,
                                      bottom: 10,
                                      child: Text("${snapshot.data!.docs[index]['cost']}/-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    )

                                  ],

                                ),
                              ),
                            );

                          },

                        );
                    }
                )
            ),


            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Mobile service".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)
                // ,Text("See All".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 14),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,

                children: [
                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayPage(
                                createdid: _uid,
                                createdby: _name,
                                phone: _phone,
                                location: _location,


                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Display",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BatteryPage(
                                createdid: _uid,
                                createdby: _name,
                                phone:_phone,
                                location:_location

                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Battery change",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PortPage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location
                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Port service",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BodyPage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location
                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Body changing",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraPage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location
                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Camera Change",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaterPage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location
                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Water Damage",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpeakerPage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location

                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Speaker Repair",style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SoftwarePage(
                                createdid: _uid,
                                createdby: _name,
                                  phone:_phone,
                                  location:_location

                              )));

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 40,
                            backgroundImage: AssetImage('assets/img/display.jpg'),
                          ),
                          Text("Software",style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ],
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
