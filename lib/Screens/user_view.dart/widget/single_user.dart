
import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/user_view.dart/edit_user.dart';
import 'package:progamingadminapp/models/user_model.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const SingleUserCard({super.key,required this.userModel,required this.index});

  @override
  State<SingleUserCard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SingleUserCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                  widget.userModel.image !=null
                   ?  CircleAvatar(
                    backgroundImage:NetworkImage(widget.userModel.image!) ,
                   )  
                   : const CircleAvatar(
                    child: Icon(Icons.person,),
                   ),  
              const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
            
                        Text(widget.userModel.email),

                      ],
                    ),
                    const Spacer(),
                    isLoading
                    ? const CircularProgressIndicator()
                    : IconButton(
                      onPressed: ()async{
                        setState(() {
                          isLoading = true;
                        });
                      await appProvider.deleteUserFromFirebase(widget.userModel);
                       setState(() {
                          isLoading = false;
                        });
                      },
                       icon: const Icon(Icons.delete,color: Colors.red,)
                       ),
                       IconButton(
                      onPressed: ()async{
                        Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) =>  EditUserPage(index: widget.index,userModel: widget.userModel),));
                      },
                       icon: const Icon(Icons.edit,color: Colors.black,)
                       )
                   ],
                  ),
                ),
              );
  }
}