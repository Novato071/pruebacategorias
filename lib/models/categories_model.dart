import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  String id = "";
  String title = "";
  String subtitle = "";
  String urlImage = "";

  CategoriesModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.urlImage,
  });

  CategoriesModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    title = documentSnapshot['title'];
    subtitle = documentSnapshot['subtitle'];
    urlImage = documentSnapshot['urlImage'];
  }
}
