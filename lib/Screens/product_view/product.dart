// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/product_view/add_product/add_product.dart';
import 'package:progamingadminapp/Screens/product_view/widgets/single_product.dart';
import 'package:progamingadminapp/models/product_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider =Provider.of<AppProvider>(context);
    return Scaffold(
       appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: ()async{
                        Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) => AddProductPage()));
          },
           icon: const Icon(Icons.add_circle))
        ],
      ),
      body:  GridView.builder(
      itemCount: appProvider.getproductList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        ProductModel singleProduct = appProvider.getproductList[index];
        return SingleProductView(
          singleProduct: singleProduct,
          index: index,
          );
      },
    ),
    );
  }
}