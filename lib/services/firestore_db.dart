import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:needs_customer/models/models.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class FirestoreDB {
  static Stream<List<CategoriesModel>> categoryStream() {
    return firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CategoriesModel> categories = [];
      for (var category in query.docs) {
        final categoriesModel =
            CategoriesModel.fromDocumentSnapshot(documentSnapshot: category);
        categories.add(categoriesModel);
      }
      return categories;
    });
  }

  static Stream<List<SubCategoriesModel>> subCategoryStream(String? uid) {
    return firebaseFirestore
        .collection('categories')
        .doc(uid)
        .collection('subcategories')
        .snapshots()
        .map((QuerySnapshot query) {
      List<SubCategoriesModel> subCategories = [];
      for (var subCategory in query.docs) {
        final subCategoriesModel = SubCategoriesModel.fromDocumentSnapshot(
            documentSnapshot: subCategory);
        subCategories.add(subCategoriesModel);
      }
      return subCategories;
    });
  }
}
