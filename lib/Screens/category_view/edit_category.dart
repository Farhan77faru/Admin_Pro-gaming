// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';


import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/helpers/firebase_storage.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';


class EditCategoryPage extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const EditCategoryPage({super.key,required this.categoryModel,required this.index});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
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
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          title:const Text(
            "Category Edit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
        image ==null 
         ? GestureDetector(
            onTap: () {
              takePicture();
            },       
            child: CircleAvatar(
              radius: 70,
              child: const Icon(Icons.camera_alt),
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
              hintText: widget.categoryModel.name
    
            ),
          ),
           SizedBox(height: 10,),
           TextButton(
            onPressed:()async{
              if(image==null && name.text.isEmpty){
                Navigator.of(context).pop();
              }
            else  if(image !=null){
            String imageUrl = await FirebaseStorageHelper.instance
              .uploadUserImage(widget.categoryModel.id,image!);
              CategoryModel categoryModel = widget.categoryModel.copyWith(
              image: imageUrl,
              name: name.text.isEmpty?null:name.text
              );
              appProvider.updateCategoryList(widget.index, categoryModel);
             ShowMessage("Update Succesfully");
              Navigator.of(context).pop();  
              } else{
              CategoryModel categoryModel = widget.categoryModel.copyWith(
              name: name.text.isEmpty?null:name.text
              );
              appProvider.updateCategoryList(widget.index, categoryModel);
             ShowMessage("Update Succesfully");
             Navigator.of(context).pop();  
              } 
              
            },
            child: const Text("Update"),
          
            )
        ],
      ),
    ),
    );
  }
}