import 'package:flutter/material.dart';
import 'package:servicify/screens/constants/colors.dart';
import 'package:servicify/screens/constants/textstyles.dart';

class RamUpgrade extends StatefulWidget {
  const RamUpgrade({super.key});

  @override
  State<RamUpgrade> createState() => _RamUpgradeState();
}

class _RamUpgradeState extends State<RamUpgrade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          "Ram Upgrade ",
          style: appbarStyle,
        ),
      ),
    );
  }
}