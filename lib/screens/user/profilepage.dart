import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/custombutton.dart';
import 'package:servicify/screens/user/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../common/login_page.dart';
import '../constants/customtext.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? _name;
  String? _email;
  String? _phone;
  String? token;
  String? _location;
  var imggurl;

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

    imggurl = await _pref.getString(
      'imgurl',
    );
    print(imggurl);

    // if (imggurl == null) {
    //   setState(() {
    //     imggurl = "assets/image/profile.png";
    //   });
    // }

    _uid = await _pref.getString(
      'uid',
    );

    print(data);
    setState(() {
      data = {
        "name": _name,
        "email": _email,
        "phone": _phone,
        "uid": _uid,
        "img": imggurl,
        "location": _location
      };
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
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(13),
      //       child: InkWell(
      //           onTap: (){
      //             Navigator.pushAndRemoveUntil(
      //                 context, MaterialPageRoute(builder:
      //                 (context)=>LoginPage()),
      //                     (route) => false
      //             );
      //           },
      //           child: Icon(Icons.logout)),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,

          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 180),
                      child: CircleAvatar(
                        radius: 55.0,

                        child: Center(
                          child: CustomText(
                            fontWeight: FontWeight.bold,
                            data: "${_name?[0]}",
                            size: 28,

                          ),
                        ),

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CustomText(
                        fontWeight: FontWeight.bold,
                        data: "${_name}",
                        size: 22,

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 28),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email),
                          CustomText(data:'${_email}',size: 18 ,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          CustomText(data:'${_phone}',size: 18 ,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          CustomText(data:'${_location}',size: 18 ,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100,),
                CustomButton(
                    width: 100,
                    color: primaryColor,
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDetails(
                                    uid: _uid,
                                    name: _name,
                                    phno: _phone,

                                    location: _location,

                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        data: "Edit",
                        ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
