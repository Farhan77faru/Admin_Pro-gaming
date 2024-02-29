// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/product_view/edit_product/edit_product.dart';
import 'package:progamingadminapp/models/product_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({super.key,required this.singleProduct,required this.index});
  final int index;
  final ProductModel singleProduct;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
 bool isLoading=false;
  @override
  Widget build(BuildContext context) {
     AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFD4ECF7),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom:10,
              left: 10,
            ),
            child: Stack(
              children:[
                 Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '30% off',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      bottom: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                      
                      },
                      child: Image.network(
                        widget.singleProduct.image,
                        height:150,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.singleProduct.name,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height:10,
                        ),
                        Text(
                          "\$${widget.singleProduct.price}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
                          .deleteProductFromFirebase(widget.singleProduct);
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
                      builder: (context) => EditProductPage(productModel: widget.singleProduct, index: widget.index)));
                  },
                  child: const Icon(Icons.edit),
                )
              ],
            ),
          ),
        )
           ] ),
          ),
        );
  }
}