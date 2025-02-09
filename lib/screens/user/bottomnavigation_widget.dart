


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:servicify/screens/user/services/bottombar_service.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarServiceProvider>(
      builder: (context,provider,child){

        return  BottomNavigationBar(
          currentIndex:provider.selectedIndex,

          onTap:(value){
            provider.changeIndex(value);
            print(provider.selectedIndex);
          },
          items: [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),label: "Home",backgroundColor:Color(0xff18A8D8) ),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Bookmark",backgroundColor:Color(0xff18A8D8)),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings",backgroundColor:Color(0xff18A8D8)),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile",backgroundColor:Color(0xff18A8D8)),
          ],
        );
      },

    );
  }
}