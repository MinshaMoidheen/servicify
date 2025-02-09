import 'package:flutter/material.dart';
import 'package:servicify/screens/admin/add_freelancer_page.dart';
import 'package:servicify/screens/admin/add_user_page.dart';
import 'package:servicify/screens/admin/addnotification.dart';
import 'package:servicify/screens/admin/addreply.dart';
import 'package:servicify/screens/admin/addshop_page.dart';
import 'package:servicify/screens/admin/addtips.dart';
import 'package:servicify/screens/admin/viewAllnotifications.dart';
import 'package:servicify/screens/admin/viewall_freelancers.dart';
import 'package:servicify/screens/admin/viewall_payments.dart';
import 'package:servicify/screens/admin/viewall_user.dart';
import 'package:servicify/screens/admin/viewallcomplaints_admin.dart';
import 'package:servicify/screens/admin/viewallshops_page.dart';
import 'package:servicify/screens/admin/viewtips.dart';
import 'package:servicify/screens/common/login_page.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';

import 'viewFeedbacks.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(

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
                        child: Text("A",style: TextStyle(color: Colors.white,fontSize: 20),),
                      backgroundColor: primaryColor,
                      radius: 30,
                      ),
                      SizedBox(height: 10,),
                      Text("admin@gmail.com",style: TextStyle(color: primaryColor),)
                    ],
                  )
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
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.grid_view_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        title: Text(
          "Admin Dashboard",
          style: appbarStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shop Management",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
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
                                      builder: (context) => AddShopPage()));
                            },
                            child: Text(
                              "Add Shop",
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
                                      builder: (context) => ViewAllShops()));
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
              SizedBox(
                height: 15,
              ),
              Text(
                "Freelancer Management",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
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
                                  builder: (context) => AddFreelancer()));
                        },
                        child: Text(
                          "Add Freelancer",
                          style: appbarStyle,
                        ),
                      ))),
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
                                      builder: (context) =>
                                          ViewAllFrelancers()));
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
              SizedBox(
                height: 15,
              ),
              Text(
                "Users Management",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
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
                                      builder: (context) => AddUserPage()));
                            },
                            child: Text(
                              "Add User",
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
                                      builder: (context) => ViewAllUsers()));
                            },
                            child: Text(
                              "View all",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),


              Text(
                "Laptop Services",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
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
                                      builder: (context) => AddUserPage()));
                            },
                            child: Text(
                              "Add lap service",
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
                                      builder: (context) => ViewAllUsers()));
                            },
                            child: Text(
                              "View all",
                              style: appbarStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),


              Text(
                "Complaints & Feedbacks",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 150,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddReply()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "View Complaints",
                            style: appbarStyle,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewFeedbacks()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "View Feebacks",
                            style: appbarStyle,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   height: 100,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: primaryColor,
                    //   ),
                    //   child: Center(
                    //     child: Text("View Complaints",style: appbarStyle,),
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   height: 100,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: primaryColor,
                    //   ),
                    //
                    // )
                  ],
                ),
              ),
              Text(
                "Notification Management",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5.0,
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: Row(
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    "Add Notification",
                                    style: appbarStyle,
                                  ))),
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: InkWell(
                                        onTap: (){

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotification()));
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ))
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotifications()));
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "View All",
                                  style: appbarStyle,
                                ),
                              ),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Add Tips",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),

              Card(
                elevation: 5.0,
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                "Add Tips",
                                                style: appbarStyle,
                                              ))),
                                      CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: InkWell(
                                            onTap: (){

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTips()));
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                          ))
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllTips()));
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "View All",
                                  style: appbarStyle,
                                ),
                              ),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              ),


              Text(
                "Payment Management",
                style: subtitleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5.0,
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Stack(
                      children: [

                        Center(
                          child: InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllPayments()));
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "View All",
                                  style: appbarStyle,
                                ),
                              ),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
