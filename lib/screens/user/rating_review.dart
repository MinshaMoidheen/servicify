

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servicify/constants/colors.dart';

import 'package:uuid/uuid.dart';

import '../../utils/appbutton.dart';
import '../../utils/rating_widgt.dart';

class RatingAndReviewPage extends StatefulWidget {

  final id;
  final userid;
  final servicerid;
  final username;
  final serviceby;

  RatingAndReviewPage({required this.id,this.servicerid,this.userid,this.username,this.serviceby});

  @override
  _RatingAndReviewPageState createState() => _RatingAndReviewPageState();
}

class _RatingAndReviewPageState extends State<RatingAndReviewPage> {
  TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text("Ratings and Reviews",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 2,color: Colors.teal,),
              SizedBox(height: 20),
              Text("Share Your Thoughts: Rate and Review this Course! Your feedback matters—contribute your insights and experiences to help others in their learning journey. Your ratings and reviews add valuable perspectives to the course community",style: TextStyle(color: Colors.white),),
              SizedBox(height: 20),
              Divider(height: 2,color: Colors.teal,),
              SizedBox(height: 20),
              Center(
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  unratedColor: Colors.grey,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _commentController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Write your review...",
                    hintStyle: TextStyle(color: Colors.white)
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: AppButton(
                  height: 45,
                  width: 250,
                  color: AppColors.btnPrimaryColor,
                  onTap: () async {
                    await submitReview();
                    Navigator.pop(context); // Navigate back to CourseDetails after submitting review
                  },
                  child: Text("Submit Review",style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 2,color: Colors.teal,),
              SizedBox(height: 20),
              Text("Recent Reviews",style: TextStyle(color: Colors.white),),
              SizedBox(height: 20),
              StreamBuilder(


                  stream: FirebaseFirestore.instance.collection('reviews').where('userId',isEqualTo: widget.userid).snapshots(),


                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasError){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        shrinkWrap:true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          var rating=snapshot.data!.docs[index];
                          return Card(
                            color: AppColors.scaffoldColor,
                            elevation: 5.0,
                            child: ListTile(

                              title: Text("${rating['comment']}",style: TextStyle(color: Colors.white),),
                              subtitle:   StarRating(rating: double.parse(rating['rating'].toString())),
                            ),
                          );
                        });
                  }


              )

            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitReview() async {
    if (_rating == 0.0) {
      // Show an error message or handle accordingly
      return;
    }

    var reviewData = {
      'rating': _rating,
      'comment': _commentController.text,
    };


    var id=Uuid().v1();


    await FirebaseFirestore.instance.collection('reviews').doc(id).set({
      'Id': widget.id,
      'rating': _rating,
      'comment': _commentController.text,
      'userId': widget.userid,
      'username':widget.username,
      'servicerid':widget.servicerid,
      'servicername':widget.serviceby
    });
  }
}
