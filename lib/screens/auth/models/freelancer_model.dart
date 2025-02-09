import 'package:cloud_firestore/cloud_firestore.dart';

class FreelancerModel {
  String? uid;

  String? email;
  String? name;
  String? phone;
  String? password;
  String? imgurl;
  String? location;
  String? category;
  String? services;



  int? status;
  DateTime? createdAt;

  FreelancerModel(
      {this.createdAt,
        this.category,this.services,




        this.status,
        this.uid,
        this.email,
        this.name,
        this.password,
        this.phone,
        this.imgurl,
        this.location});

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    return FreelancerModel(
      status: json['status'],

      uid: json['uid'],
      email: json['email'],
      name: json['freelancername'],
      phone: json['phone'],
      location: json['location'],
      imgurl: json['imgurl'],
      services: json['services'],
      category: json['category'],

      createdAt: json['createdAt'],
      // skills: List<String>.from(json['skills'])??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'uid': uid,

      'email': email,
      'location': location,
      'freelancername':name,
      'category':category,
      'services':services,


      'imgurl': imgurl,
      'createdAt': createdAt!.toIso8601String(),

    };
  }

  static FreelancerModel fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return FreelancerModel.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final data = toJson();

    return data;
  }
}
