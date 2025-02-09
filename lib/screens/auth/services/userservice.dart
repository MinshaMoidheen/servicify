

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:servicify/screens/auth/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';


class UserService {
  //firebase reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _loginCollection =
  FirebaseFirestore.instance.collection('login');
  final CollectionReference _freelanceCollection =
  FirebaseFirestore.instance.collection('freelancer');
  final CollectionReference _shopCollection =
  FirebaseFirestore.instance.collection('shop');

  //Register user

  Future<void> registerUser(UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());

    await FirebaseFirestore.instance.collection('login').doc(userCredential.user!.uid).set({

      'uid':userCredential.user!.uid,
      'email':userCredential.user!.email,
      'usertype': "user",
      'password':user.password,
      'createdat':DateTime.now(),
      'status':1
    });

    await _userCollection.doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'password': user.password,
      'name': user.name,
      'phone': user.phone,
      'location': user.location,
      'imgurl': user.imgurl,
      'status': 1,
      'usertype': "user",
      'createdat': DateTime.now()
    }).then((value) => null);
    SharedPreferences _pref=await SharedPreferences.getInstance();
    var snap = await _userCollection.doc(userCredential.user!.uid).get();

    String? token = await userCredential.user!.getIdToken();

    await _pref.setString('token', token!);
    print("Token is: $token");

    String? _name = snap['name'];
    String? _email = snap['email'];
    String? _phone = snap['phone'];
    String? _location = snap['location'] ?? "Not Set";
    String? _imgurl = snap['imgurl'] ?? "assets/images/profile.png";
    String? _type = snap['usertype'];
    String? _uid = snap['uid'];




    await _pref.setString('token', token);
    await _pref.setString('uid', _uid!);
    await _pref.setString('name', _name!);
    await _pref.setString('email', _email!);
    await _pref.setString('phone', _phone!);
    await _pref.setString('type', _type!);
    await _pref.setString('imgurl', _imgurl!);
    await _pref.setString('location', _location!);






  }




  //update user
  Future<void> updateUser(UserModel user) async {
    SharedPreferences _pref=await SharedPreferences.getInstance();

    await _userCollection.doc(user.uid).update({
      'uid': user.uid,
      'phone': user.phone,
      'location': user.location,
      'imgurl': user.imgurl,
      'status':user.status
    }).then((value) async {

      await _pref.setString('name', user.name.toString());
      await _pref.setString('phone', user.phone.toString());

      await _pref.setString('imgurl', user.imgurl.toString());
      print(await _pref.getString('imgurl'));
      await _pref.setString('location', user.location.toString());

      //await _pref.setDouble('credits',_credits!);
    });
  }

  //user login and sharedpreference

  Future<DocumentSnapshot> loginUser(UserModel user) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());

    var snap = await _loginCollection.doc(userCredential.user!.uid).get();

    String? token = await userCredential.user!.getIdToken();

    await _pref.setString('token', token!);
    print("Token is: $token");

    if (snap['usertype'] == "user") {
      var user = await _userCollection.doc(userCredential.user!.uid).get();
      String? _name = user['name'];
      String? _email = snap['email'];
      String? _phone = user['phone'];
      String? _location = user['location'] ?? "Not Set";
      String? _imgurl = user['imgurl'] ?? "assets/images/profile.png";
      String? _type = snap['usertype'];
      String? _uid = snap['uid'];



      await _pref.setString('token', token);
      await _pref.setString('uid', _uid!);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('usertype', _type!);
      await _pref.setString('imgurl', _imgurl!);
      await _pref.setString('location', _location!);


      return user;
    }

    else if (snap['usertype'] == "freelancer") {
      var freelacer = await _freelanceCollection.doc(userCredential.user!.uid).get();
      String? _name = freelacer['name'];
      String? _email = snap['email'];
      String? _phone = freelacer['phone'];
      String? _type = snap['usertype'];
      String? _uid = snap['uid'];

      String? _location = freelacer['location'];
      String? _password = freelacer['password'];
      String? _category = freelacer['category'];
      String? _services = freelacer['services'];
      await _pref.setString('password', _password!);
      await _pref.setString('location', _location!);
      await _pref.setString('token', token);
      await _pref.setString('uid', _uid!);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('usertype', _type!);
      await _pref.setString('category', _category!);
      await _pref.setString('services', _services!);

      return freelacer;
    }

    else if (snap['usertype'] == "shop") {
      var shop = await _shopCollection.doc(userCredential.user!.uid).get();
      String? _name = shop['name'];
      String? _email = snap['email'];
      String? _phone = shop['phone'];
      String? _type = snap['usertype'];
      String? _uid = snap['uid'];
      String? _location = shop['location'];
      String? _password = shop['password'];
      String? _category = shop['category'];
      String? _services = shop['services'];
      await _pref.setString('password', _password!);
      await _pref.setString('location', _location!);
      await _pref.setString('token', token);
      await _pref.setString('uid', _uid!);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('usertype', _type!);
      await _pref.setString('category', _category!);
      await _pref.setString('services', _services!);

      return shop;
    }

    await _pref.setInt('exp', 0);
    return snap;
  }

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.clear();

    String? _token = await pref.getString('token');

    print(_token);
  }

  Future<bool> isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? _token = await pref.getString('token');
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<UserModel>> GetAllUsers(String?city) async {
    print(city);
    QuerySnapshot snap =
    await _userCollection.where('city',isEqualTo: city).where('usertype',isEqualTo:"user").get();

    List<UserModel> data = [];

    for (var snapshot in snap.docs) {
      print("hello jbin");
      UserModel house = UserModel.fromSnapshot(snapshot);
      data.add(house);
    }

    return data;
  }
  Future<UserModel> getUSerById(String eventId) async {
    final DocumentSnapshot snapshot =
    await _userCollection.doc(eventId).get();

    if (snapshot.exists) {
      final UserModel user =UserModel.fromSnapshot(snapshot);
      return user;
    } else {
      throw Exception('user not found.');
    }
  }



  // all users

  Future<List<UserModel>> GetAll() async {

    QuerySnapshot snap =
    await _userCollection.where('usertype',isEqualTo:"user").get();

    List<UserModel> data = [];

    for (var snapshot in snap.docs) {
      print("hello jbin");
      UserModel house = UserModel.fromSnapshot(snapshot);
      data.add(house);
    }

    return data;
  }
}
