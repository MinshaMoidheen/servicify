
import 'package:flutter/material.dart';

import 'package:servicify/constants/colors.dart';


class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(

        text:
        TextSpan(
            text:  "Service\n",
            style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Clash Display",fontWeight: FontWeight.w500)
            ,children: [
          TextSpan(
              text: "at your ",
              style: TextStyle(color: AppColors.btnPrimaryColor,fontSize: 33,fontFamily: "Clash Display",fontWeight: FontWeight.w700)
          ),

          TextSpan(
              text: "Door Steps \n",
              style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Clash Display",fontWeight: FontWeight.w500)
          ),


        ]),

      ),
    );
  }
}