import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/user_view.dart/widget/single_user.dart';
import 'package:progamingadminapp/models/user_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Views"),
      ),
      body: Consumer<AppProvider>(
        builder: (context,value,child){
          return ListView.builder(
            itemCount:  value.getUserList.length,
            itemBuilder: (context,index){
              UserModel userModel = value.getUserList[index];
              return SingleUserCard(
                userModel: userModel,
                index: index,);
            });
        }),
    );
  }
}