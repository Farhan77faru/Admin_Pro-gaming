
import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/category_view/edit_category.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleCategoryView extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryView({super.key, required this.singleCategory,required this.index});

  @override
  State<SingleCategoryView> createState() => _SingleCategoryViewState();
}

class _SingleCategoryViewState extends State<SingleCategoryView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
         Center(
           child: Image.network(
            widget.singleCategory.image,
            fit: BoxFit.cover,
            scale: 2,
                 ),
         ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IgnorePointer(
                  ignoring: isLoading,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                    await appProvider
                          .deleteCategoryFromFirebase(widget.singleCategory);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) =>  EditCategoryPage(index: widget.index,categoryModel: widget.singleCategory),));
                  },
                  child: const Icon(Icons.edit),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}