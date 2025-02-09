import 'package:flutter/material.dart';
import 'package:servicify/screens/admin/viewAllnotifications.dart';
import 'package:servicify/screens/admin/viewtips.dart';
import 'package:servicify/screens/common/login_page.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/shop/acceptedshoprequest.dart';
import 'package:servicify/screens/shop/addcomplaintshop.dart';
import 'package:servicify/screens/shop/addfeedbackshop.dart';
import 'package:servicify/screens/shop/addmobilesevice.dart';
import 'package:servicify/screens/shop/addshopservice.dart';
import 'package:servicify/screens/shop/addworker.dart';
import 'package:servicify/screens/shop/review.dart';
import 'package:servicify/screens/shop/shopbooking.dart';
import 'package:servicify/screens/shop/shopcomplaintreply.dart';
import 'package:servicify/screens/shop/viewlaptopservice.dart';
import 'package:servicify/screens/shop/viewmobileservice.dart';
import 'package:servicify/screens/shop/viewnotification.dart';
import 'package:servicify/screens/shop/viewtips.dart';
import 'package:servicify/screens/shop/viewworkers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
class ShopHome extends StatefulWidget {

  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {

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
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          builder: (context) => ShopComplaintRegistration(
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
                          builder: (context) => ShopComplaintReply(
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
                          builder: (context) => ShopFeedbackRegistration(
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
      ),
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Shop Home",
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
                                      builder: (context) => AddLapService(
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
                                      builder: (context) => ViewLapServices(
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
                              "Add Mobile services",
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
                                      builder: (context) => ViewMobileServices(
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
                                      builder: (context) => AddWorker(
                                          createdid: _uid,
                                          createdby:_name
                                      )));
                            },
                            child: Text(
                              "Add Workers",
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
                                      builder: (context) => ViewWorkers(
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
                                      builder: (context) =>ShopBooking(id: _uid,)));
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
                                      builder: (context) =>AcceptShopRequest(
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
                                      builder: (context) => ReviewShop(
                                          shopid: _uid,

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
