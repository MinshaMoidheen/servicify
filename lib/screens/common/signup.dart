import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servicify/constants/colors.dart';
import 'package:servicify/data/city_list.dart';
import 'package:servicify/screens/auth/models/user_model.dart';
import 'package:servicify/screens/auth/services/userservice.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/user/bottm_navigation_page.dart';
import 'package:servicify/utils/appbutton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _regkey = GlobalKey<FormState>();
  var _usernamecontroller = TextEditingController();
  var _passwordcontroller = TextEditingController();
  var _namecontroller = TextEditingController();
  var _phonecontroller = TextEditingController();
  var _locationcontroller = TextEditingController();
  bool visible = true;

  String?selectedCity;

  final _regKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //backgroundColor: Colors.red,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _regKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        child: Image.asset(
                  "assets/img/logo.png",
                  scale: 4,
                ))),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  controller: _namecontroller,
                  cursorColor: Colors.redAccent,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    hintText: "User Name",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: primaryColor,
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  controller: _phonecontroller,
                  cursorColor: Colors.redAccent,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primaryColor,
                    ),
                    hintText: "Mobile No",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: primaryColor,
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  controller: _usernamecontroller,
                  cursorColor: Colors.redAccent,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: primaryColor,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: primaryColor,
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: visible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  controller: _passwordcontroller,
                  cursorColor: Colors.redAccent,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (visible == true) {
                          setState(() {
                            visible = false;
                          });
                        } else {
                          setState(() {
                            visible = true;
                          });
                        }
                      },
                      icon: visible == true
                          ? Icon(
                              Icons.visibility_off,
                              color: primaryColor,
                            )
                          : Icon(
                              Icons.visibility,
                              color: primaryColor,
                            ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: primaryColor,
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(

                    hintText: "Select City",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                  value: selectedCity,
                  items: malappuramCities
                      .map((city) => DropdownMenuItem<String>(
                      value: city, child: Text(city)))
                      .toList(),
                  onChanged: (value) {

                    selectedCity=value;

                  },
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  controller: _locationcontroller,
                  cursorColor: Colors.redAccent,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: primaryColor,
                    ),
                    hintText: "Address",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Center(
                  child: AppButton(
                    onTap: () {
                      var res = _regKey.currentState!.validate();

                      if (_regKey.currentState!.validate()) {

                        _register();
                      } else {
                        print("validation error");
                      }
                    },
                    height: 45,
                    width: 250,
                    color: AppColors.btnPrimaryColor,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Registered?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;
  UserService _userService = UserService();
  void _register() async {
    setState(() {
      _isLoading = true;
    });
    UserModel _user = UserModel(
      email: _usernamecontroller.text,
      password: _passwordcontroller.text,
      phone: _phonecontroller.text,
      name: _namecontroller.text,
      location: selectedCity


    );

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _userService.registerUser(_user).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
            (route) => false);
      });

      // Navigate to the next page after registration is complete
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      List err = e.toString().split("]");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          duration: Duration(seconds: 3),
          content: Container(
            height: 85,
            child: Center(
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text(err[1].toString())),
                ],
              ),
            ),
          ),
        ),
      );


    }

    // Simulate registration delay
  }
}
