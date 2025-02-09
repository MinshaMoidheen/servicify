import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';


class ViewFrlcrMobileServices extends StatefulWidget {
  const ViewFrlcrMobileServices({super.key});

  @override
  State<ViewFrlcrMobileServices> createState() => _ViewFrlcrMobileServicesState();
}

class _ViewFrlcrMobileServicesState extends State<ViewFrlcrMobileServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "View mobile services",
          style: appbarStyle,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){


                return Card(
                  child: ListTile(


                    title: Text("Title"),
                    subtitle: Text("Description"),
                  ),
                );

              })
      ),

    );
  }
}

