// ignore_for_file: empty_catches, avoid_print

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progamingadminapp/helpers/firebase_storage.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:progamingadminapp/models/order_model.dart';
import 'package:progamingadminapp/models/product_model.dart';
import 'package:progamingadminapp/models/user_model.dart';


class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
 final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
 

  Future<List<UserModel>>getUserList()async{
QuerySnapshot<Map<String,dynamic>> querySnapshot =
await _firebaseFirestore.collection("users").get();
return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data())) 
          .toList();

      return categoriesList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<String>deleteSingleUser(String id)async{
    try{
  await  _firebaseFirestore.collection("users").doc(id).delete();
   return "Succesfully Deleted";
  }catch(e){
   return e.toString();
  }
  }

  Future<void>updateUser(UserModel userModel)async{
    try{
  await  _firebaseFirestore
  .collection("users")
  .doc(userModel.id)
  .update(userModel.toJson());

  }catch(e){}
  }

  //category//

   Future<String>deleteSingleCategory(String id)async{
    try{
  await  _firebaseFirestore.collection("categories").doc(id).delete();

   return "Succesfully Deleted";
  }catch(e){
   return e.toString();
  }
  }

  Future<void>updateCategory(CategoryModel categoryModel)async{
    try{
  await  _firebaseFirestore
  .collection("categories")
  .doc(categoryModel.id)
  .update(categoryModel.toJson());

  }catch(e){}
  }


  Future<CategoryModel>addCategory(File image,String name)async{  
  DocumentReference reference =  _firebaseFirestore
  .collection("categories").doc();
  String imageUrl =  await FirebaseStorageHelper.instance.uploadUserImage(reference.id, image);
  CategoryModel addCategory = CategoryModel(
    id: reference.id,
     image:imageUrl,
      name: name,
      );
    await reference.set(addCategory.toJson());  
    return addCategory;
 
  }
  
  //PRODUCTS///


  Future<List<ProductModel>> getProducts()async{
  QuerySnapshot<Map<String,dynamic>> querySnapshot =  
  await  _firebaseFirestore.collectionGroup("games").get();
  List<ProductModel> productList = querySnapshot.docs
  .map((e) => ProductModel
  .fromJson(e.data()))
  .toList();
  return productList;
  }


   Future<String>deleteSingleProduct(String categoryId,String productId)async{
    try{
  await  _firebaseFirestore
  .collection("categories")
  .doc(categoryId)
  .collection("games")
  .doc(productId)
  .delete();

   return "Succesfully Deleted";
  }catch(e){
   return e.toString();
  }
  }

  Future<void>updateProduct(ProductModel productModel)async{
    try{
 await  _firebaseFirestore
  .collection("categories")
  .doc(productModel.categoryId)
  .collection("games")
  .doc(productModel.id)
  .update(productModel.toJson());
  }catch(e){}
  }
  Future<ProductModel>addProduct(
    File image,
    String name,
    String categoryId,
    
    String price,
    String description,
  )async{  
  DocumentReference reference =  _firebaseFirestore
  .collection("categories")
  .doc(categoryId)
  .collection("games")
  .doc();
  String imageUrl =  await FirebaseStorageHelper.instance
  .uploadUserImage(reference.id, image);
  ProductModel addProduct = ProductModel(
    id: reference.id,
     image:imageUrl,
      name: name,
      categoryId: categoryId,
      description: description,
      price: double.parse(price),
      isFavorite: false,
      count: 1
      );
    await reference.set(addProduct.toJson());  
    return addProduct;
 
  }



Future<List<OrderModel>>getCompletedOrders()async{

 QuerySnapshot<Map<String,dynamic>> completedOrders =
 await  _firebaseFirestore
 .collection("orders")
 .where("status",isEqualTo: "completed")
 .get();

 List<OrderModel> completedOrdersList = 
 completedOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
 return completedOrdersList;
  
  }

Future<List<OrderModel>>getCanceledOrders()async{

 QuerySnapshot<Map<String,dynamic>> canceledOrders =
 await  _firebaseFirestore
 .collection("orders")
 .where("status",isEqualTo: "cancel")
 .get();

 List<OrderModel> canceledOrdersList = 
 canceledOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
 return canceledOrdersList;
  
  }

  Future<List<OrderModel>>getpendingOrders()async{

 QuerySnapshot<Map<String,dynamic>> pendingOrders =
 await  _firebaseFirestore
 .collection("orders")
 .where("status",isEqualTo:"pending")
 .get();

 List<OrderModel> pendingOrdersList = 
 pendingOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
 return pendingOrdersList;
  
  }

   Future<List<OrderModel>>getDeliveryOrders()async{

 QuerySnapshot<Map<String,dynamic>> deliveryOrders =
 await  _firebaseFirestore
 .collection("orders")
 .where("status",isEqualTo:"Delivery")
 .get();

 List<OrderModel> deliveryOrdersList = 
 deliveryOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
 return deliveryOrdersList;
  
  }

   Future<void>updateOrder(OrderModel orderModel,String status)async{

    await _firebaseFirestore
      .collection("Userorders")
      .doc(orderModel.userId)
      .collection("orders")
      .doc(orderModel.orderId)
      .update({
        "status":status,
      });
     
    await _firebaseFirestore
      .collection("orders")
      .doc(orderModel.orderId)
      .update({
        "status":status,
      });
  
  }
}