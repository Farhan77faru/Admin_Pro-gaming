// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';


class AddCategory extends StatefulWidget {

  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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
            "Category Add",
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
              hintText: "Category Name"
    
            ),
          ),
           SizedBox(height: 10,),
           TextButton(
            onPressed:()async{
              if(image==null && name.text.isEmpty){
                Navigator.of(context).pop();
              }else  if(image !=null && name.text.isNotEmpty){       
              appProvider.addCategoryList(image!, name.text);
             ShowMessage("Succesfully Added");
              Navigator.of(context).pop();  
              } 
              
            },
            child: const Text("Add"),
          
            )
        ],
      ),
    ),
    );
  }
}