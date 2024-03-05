import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_project/model/banner_model.dart';
import 'package:intern_project/model/men_clothing_model.dart';
import 'package:intern_project/model/men_size_model.dart';
import 'package:intern_project/model/user_model.dart';

final _firestore = FirebaseFirestore.instance;

// Cloth
Stream<List<MenClothing>> readAllCloth() =>
    _firestore.collection("clothing").snapshots().map((event) =>
        event.docs.map((e) => MenClothing.fromJson(e.data())).toList());

// Banner
Stream<List<BannerClothing>> readBanner() =>
    _firestore.collection("banner").snapshots().map((event) =>
        event.docs.map((e) => BannerClothing.fromJson(e.data())).toList());

// Size
Stream<List<MenSize>> readAllClothSize(String id) => _firestore
    .collection("clothing")
    .doc(id)
    .collection("sizes")
    .orderBy('idSize', descending: false)
    .snapshots()
    .map((event) => event.docs.map((e) => MenSize.fromJson(e.data())).toList());

// Cate
Stream<List<MenClothing>> readCategoryCloth(String cate) => _firestore
    .collection("clothing")
    .where("category", isEqualTo: cate)
    .snapshots()
    .map((event) =>
        event.docs.map((e) => MenClothing.fromJson(e.data())).toList());

//User
Future<DocumentSnapshot<Map<String, dynamic>>> readUser(String id) =>
    _firestore.collection('users').doc(id).get();
