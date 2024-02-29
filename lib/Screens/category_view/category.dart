// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/category_view/add_category.dart';
import 'package:progamingadminapp/Screens/category_view/widget/single_category.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Views"),
        actions: [
          IconButton(onPressed: (){
             Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) =>  const AddCategory()));
          },
           icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: value.getCategoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    CategoryModel categoryModel =
                        value.getCategoriesList[index];
                    return SingleCategoryView(singleCategory: categoryModel,index: index,);
                  }),
            ],
          ),
        );
      }),
    );
  }
}