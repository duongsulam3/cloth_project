import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_project/model/men_clothing_model.dart';
import 'package:intern_project/model/men_size_model.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<MenClothing>> readAllCloth() =>
    _firestore.collection("clothing").snapshots().map((event) =>
        event.docs.map((e) => MenClothing.fromJson(e.data())).toList());

Stream<List<MenSize>> readAllClothSize(String id) => _firestore
    .collection("clothing")
    .doc(id)
    .collection("sizes")
    .orderBy('idSize', descending: false)
    .snapshots()
    .map((event) => event.docs.map((e) => MenSize.fromJson(e.data())).toList());

Stream<List<MenClothing>> readCategoryCloth(String cate) => _firestore
    .collection("clothing")
    .where("category", isEqualTo: cate)
    .snapshots()
    .map((event) =>
        event.docs.map((e) => MenClothing.fromJson(e.data())).toList());
