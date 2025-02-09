import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';
class MobileServDetail extends StatefulWidget {
  const MobileServDetail({super.key});

  @override
  State<MobileServDetail> createState() => _MobileServDetailState();
}

class _MobileServDetailState extends State<MobileServDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Text(
          "Mobile services",
          style: appbarStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text("Title"),
                Text("Description"),
                Text("Cost:"),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
