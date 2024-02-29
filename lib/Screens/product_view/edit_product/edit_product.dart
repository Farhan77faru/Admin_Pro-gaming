// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/helpers/firebase_storage.dart';
import 'package:progamingadminapp/models/product_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';


class EditProductPage extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProductPage({super.key,required this.productModel,required this.index});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  File? image;
  void takePicture() async{
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40,);
    if(value != null){
      setState(() {
        image= File(value.path);
      });
    }
  }
  TextEditingController name = TextEditingController();
   TextEditingController description= TextEditingController();
    TextEditingController price = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          title:const Text(
            "Product Edit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          image ==null
         ?widget.productModel.image.isNotEmpty  
           ? GestureDetector(
              onTap: () {
                takePicture();
              },       
              child:  CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.productModel.image),
              ),
            )
            :GestureDetector(
              onTap: () {
                takePicture();
              },       
              child: const CircleAvatar(
                radius: 70,
                child: Icon(Icons.camera_alt),
              ),
            )
            : GestureDetector(
              onTap: () {
                takePicture();
              },     
              child: CircleAvatar(
                radius: 70,
               backgroundImage: FileImage(image!),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: widget.productModel.name
      
              ),
            ),
             SizedBox(height: 10,),
            TextFormField(
              controller: description,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: widget.productModel.description
      
              ),
            ),
             SizedBox(height: 10,),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:"\$${widget.productModel.price.toString()}",
      
              ),
            ),
             const SizedBox(height: 10,),
             TextButton(
              onPressed:()async{
                if(image==null && name.text.isEmpty &&
                 description.text.isEmpty &&
                  price.text.isEmpty ) {
                  Navigator.of(context).pop();
                }
              else  if(image !=null){
              String imageUrl = await FirebaseStorageHelper.instance
                .uploadUserImage(widget.productModel.id,image!);
                 ProductModel productModel = widget.productModel.copyWith(
                 description: description.text.isEmpty?null : description.text,
                 image: imageUrl,
                 name: name.text.isEmpty?null : name.text,
                 price: price.text.isEmpty?null : price.text
                 );
               
                 appProvider.updateProductList(widget.index, productModel);
               ShowMessage("Update Succesfully");
                Navigator.of(context).pop();  
                } else{
                 ProductModel productModel = widget.productModel.copyWith(
                 description: description.text.isEmpty?null : description.text,
                 name: name.text.isEmpty?null : name.text,
                 price: price.text.isEmpty?null : price.text
                 );
               
                 appProvider.updateProductList(widget.index, productModel);
               ShowMessage("Update Succesfully");
               Navigator.of(context).pop();  
                } 
                
              },
              child: const Text("Update"),
            
              )
          ],
        ),
      ),
    ),
    );
  }
}