import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:needs_customer/controller/subcategories_controller.dart';
import 'package:needs_customer/models/categories_model.dart';

import '../controller/controller.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  PageController pageController = PageController(viewportFraction: 0.80);

  @override
  Widget build(BuildContext context) {
    return GetX<CategoriesController>(
      init: CategoriesController(),
      builder: (controller) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: PageView.builder(
            controller: pageController,
            itemCount: controller.categories.length,
            itemBuilder: (BuildContext context, int index) {
              final _categoryModel = controller.categories[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _categoriesInfo(_categoryModel),
                  SubCategoriesView(
                    categoriesModel: CategoriesModel(
                      id: _categoryModel.id,
                      title: _categoryModel.title,
                      subtitle: _categoryModel.subtitle,
                      urlImage: _categoryModel.urlImage,
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _categoriesInfo(CategoriesModel _categoryModel) {
    return Container(
      height: size.height * 0.33,
      width: size.width * 0.75,
      child: Center(child: Text(_categoryModel.title, style: TextStyle(fontSize: 30),)),
      
    );
  }
}

class SubCategoriesView extends StatelessWidget {
  SubCategoriesView({
    Key? key,
    required this.categoriesModel,
  }) : super(key: key);

  CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    Get.put(SubCategoriesController(categoriesModel: categoriesModel));
    return GetBuilder<SubCategoriesController>(
        init: SubCategoriesController(categoriesModel: categoriesModel),
        builder: (controller) {
          return SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: controller.subCategories.length,
              itemBuilder: (BuildContext context, int index) {
                final _subCategoryModel = controller.subCategories[index];
                return Center(
                  child: Text(_subCategoryModel.title, style: TextStyle(fontSize: 20),),
                );
              },
            ),
          );
        });
  }
}
