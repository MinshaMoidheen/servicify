import 'package:flutter/material.dart';

import 'package:servicify/constants/colors.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColors.contColor2,
      appBar: AppBar( backgroundColor: AppColors.contColor2,
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Servicify",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
               "Servicify is your trusted partner for convenient and reliable laptop and mobile services right at your doorstep. Our mission is to simplify your tech repair experience by providing professional assistance in the comfort of your own home",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Key Features:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildFeature("On demand service"),
            _buildFeature("Skilled technicians"),
            _buildFeature("Transparent pricing"),
            _buildFeature("Quality parts"),
            _buildFeature("Customer satisfaction guarantee"),
            SizedBox(height: 16),
            Text(
              "Our Mission:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "With Servicify, say goodbye to the hassle of commuting to repair shops and waiting in long queues. Our team of skilled technicians is equipped to handle a wide range of laptop and mobile issues, from software troubleshooting to hardware repairs.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(feature),
          ),
        ],
      ),
    );
  }
}


