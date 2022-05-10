import 'package:get/get.dart';
import 'package:needs_customer/models/models.dart';
import 'package:needs_customer/services/services.dart';

class SubCategoriesController extends GetxController {
  Rx<List<SubCategoriesModel>> subCategoriesList =
      Rx<List<SubCategoriesModel>>([]);
  List<SubCategoriesModel> get subCategories => subCategoriesList.value;
  CategoriesModel categoriesModel;
  SubCategoriesController({required this.categoriesModel});

  @override
  void onReady() {
    subCategoriesList
        .bindStream(FirestoreDB.subCategoryStream(categoriesModel.id));
    super.onReady();
  }
}
