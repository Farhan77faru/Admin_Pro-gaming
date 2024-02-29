// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/helpers/firebase_storage.dart';
import 'package:progamingadminapp/models/user_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';


class EditUserPage extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditUserPage({super.key,required this.userModel,required this.index});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
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
            "User Edit",
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
     
           SizedBox(height: 10,),
           TextButton(
            onPressed:()async{
              if(image==null && name.text.isEmpty){
                Navigator.of(context).pop();
              }
            else  if(image !=null){
            String imageUrl = await FirebaseStorageHelper.instance
              .uploadUserImage(widget.userModel.id,image!);
              UserModel userModel = widget.userModel.copyWith(
              image: imageUrl,
              name: name.text.isEmpty?null:name.text
              );
              appProvider.updateUserList(widget.index, userModel);
             ShowMessage("Update Succesfully");
              Navigator.of(context).pop();  
              } else{
              UserModel userModel = widget.userModel.copyWith(
              name: name.text.isEmpty?null:name.text
              );
              appProvider.updateUserList(widget.index, userModel);
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