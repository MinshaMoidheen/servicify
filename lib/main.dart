import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicify/firebase_options.dart';
import 'package:servicify/screens/common/splash_page.dart';
import 'package:servicify/screens/freelancer/freelancerhome.dart';
import 'package:servicify/screens/shop/shophome.dart';
import 'package:servicify/screens/user/services/bottombar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>BottomBarServiceProvider()),


      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,

     home: SplashPage(),
    )

    );
}
}
