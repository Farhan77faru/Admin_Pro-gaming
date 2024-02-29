import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';


class AddProductPage extends StatefulWidget {
 
  const AddProductPage({super.key,});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
  CategoryModel? _selectedCategory;
    
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context,);
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          title:const Text(
            "Add Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          image ==null      
            ?GestureDetector(
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
            const SizedBox(height: 10,),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Product Name"
      
              ),
            ),
             const SizedBox(height: 10,),
            TextFormField(
              controller: description,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "Description"
      
              ),
            ),
             const SizedBox(height: 10,),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "\$ Price",
      
              ),
            ),
            const SizedBox(height: 10,),
            DropdownButtonFormField(
              value: _selectedCategory,
              hint: const Text('Please Select Category'),
              isExpanded: true,
               onChanged: (value){
                setState(() {
                  _selectedCategory = value;
                });
               },
              items: appProvider.getCategoriesList.map((CategoryModel val){
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val.name
                    ),
                    );
              }).toList(),      
              ),
             const SizedBox(height: 10,),
             TextButton(
              onPressed:()async{
                if(
                image==null ||
                _selectedCategory==null ||
                 name.text.isEmpty ||
                 description.text.isEmpty ||
                  price.text.isEmpty) {
                ShowMessage("Please fill all information");
                  
                }
              else {
                appProvider.addProductList(
                  image!,
                  name.text,
                  _selectedCategory!.id,
                  price.text,
                  description.text
                  );                         
                ShowMessage("Update Succesfully");
                 Navigator.of(context).pop();  
                } 
                },
              child: const Text("Add"),
            
              )
          ],
        ),
      ),
    ),
    );
  }
}