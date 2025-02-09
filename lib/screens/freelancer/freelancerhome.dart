import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicify/screens/admin/viewAllnotifications.dart';
import 'package:servicify/screens/admin/viewtips.dart';
import 'package:servicify/screens/common/login_page.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/freelancer/acceptfreelancerequest.dart';
import 'package:servicify/screens/freelancer/addlapservice.dart';
import 'package:servicify/screens/freelancer/freelancebooking.dart';
import 'package:servicify/screens/freelancer/freelancecomplaint.dart';
import 'package:servicify/screens/freelancer/freelancefeedback.dart';
import 'package:servicify/screens/freelancer/freelancercomplaintreply.dart';
import 'package:servicify/screens/freelancer/reviewfreelancer.dart';
import 'package:servicify/screens/freelancer/viewlapservice.dart';
import 'package:servicify/screens/shop/addmobilesevice.dart';
import 'package:servicify/screens/shop/addshopservice.dart';
import 'package:servicify/screens/shop/addworker.dart';
import 'package:servicify/screens/shop/viewlaptopservice.dart';
import 'package:servicify/screens/shop/viewmobileservice.dart';
import 'package:servicify/screens/shop/viewnotification.dart';
import 'package:servicify/screens/shop/viewtips.dart';
import 'package:servicify/screens/shop/viewworkers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../shop/acceptedshoprequest.dart';
class FreelancerHome extends StatefulWidget {

  const FreelancerHome({super.key});

  @override
  State<FreelancerHome> createState() => _FreelancerHomeState();
}

class _FreelancerHomeState extends State<FreelancerHome> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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


  @override
  void initState() {
    getData();
    print(_name);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text("${_name![0]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                        backgroundColor: primaryColor,
                        radius: 30,
                      ),
                      SizedBox(height: 10,),
                      Text("${_email}",style: TextStyle(color: primaryColor),)
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewNotifications()));
                      },

                      child: Text("Notifications",style: TextStyle(color: primaryColor,fontSize: 18),)),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewTips()));
                      },
                      child: Text("Tips",style: TextStyle(color: primaryColor,fontSize: 18),)),

                ],
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FreelancerComplaintRegistration(
                          createdid: _uid,
                          createdby: _name,
                        )));
              },
              child: ListTile(
                title:
                Text("Complaint Registration", style: TextStyle(color: primaryColor)),

              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FreelancerComplaintReply(
                          createdid: _uid,
                          createdby: _name,
                        )));
              },
              child: ListTile(
                title:
                Text("Complaint Reply", style: TextStyle(color: primaryColor)),

              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FreelancerFeedbackRegistration(
                          createdid: _uid,
                          createdby: _name,
                        )));
              },
              child: ListTile(
                title:
                Text("Add Feedback", style: TextStyle(color: primaryColor)),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text("Logout",style: TextStyle(color: primaryColor,fontSize: 18),),
                  IconButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  }, icon: Icon(Icons.logout,color: primaryColor,))
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Freelancer Home",
          style: appbarStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddFreeLapService(
                                        createdby: _name,
                                        createdid: _uid,
                                      )));
                            },
                            child: Text(
                              "Add Lap services",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewFreeLapServices(
                                        createdid: _uid,
                                      )));
                            },
                            child: Text(
                              "View All",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddMobileService(
                                        createdby: _name,
                                        createdid: _uid,
                                      )));
                            },
                            child: Text(
                              "Add Mobile Services",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>ViewMobileServices(
                                        createdid: _uid,
                                      )));
                            },
                            child: Text(
                              "View All",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FreelanceBooking(

                                        id: _uid,)));
                            },
                            child: Text(
                              "View Booking",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>AcceptFreeRequest(
                                        id: _uid,
                                      )));
                            },
                            child: Text(
                              "Accepted Request",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewFrelancer(
                                        freelancerid: _uid,

                                      )));
                            },
                            child: Text(
                              "Reviews",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}
