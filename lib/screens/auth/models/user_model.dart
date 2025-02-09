import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;

  String? email;
  String? name;
  String? phone;
  String? password;
  String? imgurl;
  String? location;
  String? address;



  int? status;
  DateTime? createdAt;

  UserModel(
      {this.createdAt,
this.address,



        this.status,
        this.uid,
        this.email,
        this.name,
        this.password,
        this.phone,
        this.imgurl,
        this.location});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],

      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      imgurl: json['imgurl'],

      createdAt: json['createdAt'],
      address: json['address']
      // skills: List<String>.from(json['skills'])??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'uid': uid,
      'name': name,
      'email': email,
      'location': location,
'address':address,

      'imgurl': imgurl,
      'createdAt': createdAt!.toIso8601String(),

    };
  }

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    data['uid'] = snapshot.id;
    return UserModel.fromJson(data);
  }

  Map<String, dynamic> toDocument() {
    final data = toJson();

    return data;
  }
}
