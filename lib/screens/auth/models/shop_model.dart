import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
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

  ShopModel(
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

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      status: json['status'],

      uid: json['uid'],
      email: json['email'],
      name: json['shopname'],
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
      'shopname':name,
      'category':category,
      'services':services,


      'imgurl': imgurl,
      'createdAt': createdAt!.toIso8601String(),

    };
  }

  static ShopModel fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return ShopModel.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final data = toJson();

    return data;
  }
}
