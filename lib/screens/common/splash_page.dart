import 'package:flutter/material.dart';
import 'package:servicify/constants/colors.dart';
import 'package:servicify/screens/admin/admin_home_page.dart';
import 'package:servicify/screens/auth/services/userservice.dart';
import 'package:servicify/screens/common/errorpage.dart';
import 'package:servicify/screens/common/login_page.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/images.dart';
import 'package:servicify/screens/freelancer/freelancerhome.dart';
import 'package:servicify/screens/shop/shophome.dart';
import 'package:servicify/screens/user/bottm_navigation_page.dart';
import 'package:servicify/utils/appbutton_widget.dart';
import 'package:servicify/utils/header_widget.dart';
import 'package:servicify/utils/image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final String assetName = 'assets/svg/logo.svg';
  UserService _userService = UserService();
  String? _type;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('usertype');
    setState(() {});
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await _userService.isLoggedin();
    print(isLoggedIn);
    if (!isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      if (_type == "admin" ) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
                (route) => false);
      }else if(_type=="user" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
                (route) => false);
      }
      else if(_type=="freelancer" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => FreelancerHome()),
                (route) => false);
      }
      else if(_type=="shop" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ShopHome()),
                (route) => false);
      }
      else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ErrorPage(errorMessage: "Contact Administrator")),
                (route) => false);
      }

    }
  }



  @override
  void initState() {
    getData();
    // Future.delayed(
    //   Duration(seconds: 3),
    //     ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()))
    // );
    var d = Duration(seconds: 5);
    Future.delayed(d, () {
      _checkLoginStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 950) {
        return  Container();
      } else if (constraints.maxWidth > 600) {
        return Container();
      } else {
        return const MobileLayout();
      }
    })
    ;
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          height: size.height,
          width: size.width,
          child: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderWidget(),

                ImageWidget(
                    height: 350,
                    width: 350,
                    imgpath: 'logo.png'
                ),

               // Center(child: AppButtonWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}