import 'package:get/get.dart';
import 'package:needs_customer/models/models.dart';
import 'package:needs_customer/services/services.dart';

class CategoriesController extends GetxController {
  Rx<List<CategoriesModel>> categoriesList = Rx<List<CategoriesModel>>([]);
  List<CategoriesModel> get categories => categoriesList.value;

  @override
  void onReady() {
    categoriesList.bindStream(FirestoreDB.categoryStream());
    super.onReady();
  }
}
