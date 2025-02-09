import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicify/constants/colors.dart';
import 'package:servicify/data/city_list.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
import 'package:servicify/screens/user/bottm_navigation_page.dart';

import '../auth/models/user_model.dart';
import '../auth/services/userservice.dart';


class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {


  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();



  final key=GlobalKey<FormState>();


  String?selectedCity;
  bool visible=true;
  bool _checked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "Add User",
          style: appbarStyle,
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,

        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },
                  cursorColor: primaryColor,
                  controller: _nameController,

                  decoration: InputDecoration(

                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _emailController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _phoneController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(

                    hintText: "Phone",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(

                        )

                    ),

                  ),
                ),
                SizedBox(height: 10,),



                TextFormField(


                  obscureText: visible,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is mandatory";
                    }
                  },

                  controller: _passwordController,
                  cursorColor:primaryColor,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(

                      onPressed: (){

                        if(visible==true){
                          setState(() {
                            visible=false;
                          });
                        }
                        else{
                          setState(() {
                            visible=true;
                          });
                        }

                      },
                      icon: visible==true?Icon(Icons.visibility_off,color:primaryColor,):
                      Icon(Icons.visibility,color: primaryColor,),

                    ),

                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: primaryColor,
                    ),

                    enabledBorder:UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:primaryColor,
                        )

                    ),

                  ),
                ),
                SizedBox(height: 20,),
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




                SizedBox(height: 20,),

                Center(
                  child: InkWell(
                    onTap: (){

                      if(key.currentState!.validate()){
                       _register();


                      }

                    },
                    child: Container(
                      width: 250,
                      height: 49,

                      decoration: BoxDecoration(
                          color: Color(0xff1F619D),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Center(

                          child: Text("Register",style: GoogleFonts.robotoSlab(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)


                      ),
                    ),
                  ),
                ),






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
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
      name: _nameController.text,
      location: selectedCity


    );

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _userService.registerUser(_user).then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.lightGreen,
            content:
            Text("Registered Succesfully")));

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
