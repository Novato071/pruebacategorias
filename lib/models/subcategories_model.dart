import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoriesModel {
  late String uid;
  late String title;
  late String subtitle;
  late String urlImage;

  SubCategoriesModel({
    required this.uid,
    required this.title,
    required this.subtitle,
    required this.urlImage,
  });

  SubCategoriesModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot.id;
    title = documentSnapshot['title'];
    subtitle = documentSnapshot['subtitle'];
    urlImage = documentSnapshot['urlImage'];
  }
}
