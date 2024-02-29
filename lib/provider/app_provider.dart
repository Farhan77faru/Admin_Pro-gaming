import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/helpers/firebase_firestore.dart';
import 'package:progamingadminapp/models/category_model.dart';
import 'package:progamingadminapp/models/order_model.dart';
import 'package:progamingadminapp/models/product_model.dart';
import 'package:progamingadminapp/models/user_model.dart';


class AppProvider with ChangeNotifier{
 
 List<UserModel>_userList=[]; 
 List<CategoryModel>_categoriesList=[];
List<ProductModel> _productList=[];
List<OrderModel> _completedOrderList=[];
List<OrderModel> _canceledOrderList=[];
List<OrderModel> _pendingOrderList=[];
List<OrderModel> _deliveryOrderList=[];
List<String?> _usersToken =[];
double _totalEarnings = 0.0;

 Future<void>getUserListFun()async{
 _userList = await FirebaseFirestoreHelper.instance.getUserList();
 _usersToken = _userList.map((e) => e.notificationToken).toList();
 }

  Future<void>getCompletedOrdersFun()async{
 _completedOrderList = await FirebaseFirestoreHelper.instance.getCompletedOrders();
 for(var element in _completedOrderList){
  _totalEarnings += element.totalprice;
 }
 notifyListeners();
 }

   Future<void>getCanceledOrdersFun()async{
 _canceledOrderList = await FirebaseFirestoreHelper.instance.getCanceledOrders();
 notifyListeners();
 }

    Future<void>getPendingOrdersFun()async{
 _pendingOrderList = await FirebaseFirestoreHelper.instance.getpendingOrders();
 notifyListeners();
 }

Future<void>getDeliveryOrdersFun()async{
 _deliveryOrderList = await FirebaseFirestoreHelper.instance.getDeliveryOrders();
 notifyListeners();
 }

 Future<void>getCategoriesListFun()async{
 _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
 }

 Future<void>deleteUserFromFirebase(UserModel userModel)async{
  notifyListeners();
 String value  = await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);
 if(value=="Succesfully Deleted"){
  _userList.remove(userModel);
  ShowMessage("Succesfully Deleted");
 }
 notifyListeners();
 }

  List<UserModel>get getUserList => _userList;
  double get getTotalEarning => _totalEarnings;
  List<CategoryModel>get getCategoriesList => _categoriesList;
  List<ProductModel>get getproductList => _productList;
  List<OrderModel>get getCompletedOrdersList => _completedOrderList;
  List<OrderModel>get getCanceledOrdersList => _canceledOrderList;
  List<OrderModel>get getPendingOrdersList => _pendingOrderList;
  List<OrderModel>get getDeliveryOrdersList => _deliveryOrderList;
  List<String?>get getUsersToken => _usersToken;

 Future<void> callBackFunction()async{
  await  getUserListFun();
  await  getCategoriesListFun();
  await  getProducts();
  await getCompletedOrdersFun();
  await getCanceledOrdersFun();
  await getPendingOrdersFun();
  await getDeliveryOrdersFun();
  }

  void updateUserList(int index, UserModel userModel) async{
    await FirebaseFirestoreHelper.instance.updateUser(userModel);
   _userList[index]= userModel;
    notifyListeners();
  }


  Future<void>deleteCategoryFromFirebase(CategoryModel categoryModel)async{
 String value  = await FirebaseFirestoreHelper.instance.deleteSingleCategory(categoryModel.id);
 if(value=="Succesfully Deleted"){
  _categoriesList.remove(categoryModel);
  ShowMessage("Succesfully Deleted");
 }
 notifyListeners();
 }

 void updateCategoryList(int index, CategoryModel categoryModel) async{
    await FirebaseFirestoreHelper.instance.updateCategory(categoryModel);
   _categoriesList[index]= categoryModel;
    notifyListeners();
  }

   void addCategoryList(File image,String name) async{
   CategoryModel categoryModel =  await FirebaseFirestoreHelper.instance.addCategory(image,name);
   _categoriesList.add(categoryModel);
    notifyListeners();
  }

 Future<void> getProducts()async{
 _productList = await FirebaseFirestoreHelper.instance.getProducts();
 notifyListeners();
 }
 Future<void>deleteProductFromFirebase(ProductModel productModel)async{
 String value  = await FirebaseFirestoreHelper.instance
 .deleteSingleProduct(productModel.categoryId,productModel.id);
 if(value=="Succesfully Deleted"){
  _productList.remove(productModel);
  ShowMessage("Succesfully Deleted");
 }
 notifyListeners();
 }

  void updateProductList(int index, ProductModel productModel) async{
    await FirebaseFirestoreHelper.instance.updateProduct(productModel);
   _productList[index]= productModel;
    notifyListeners();
  }

   void addProductList(
    File image,
    String name,
    String categoryId,
   
    String price,
    String description,
    ) async{
   ProductModel productModel =  await FirebaseFirestoreHelper.instance.addProduct(image, name, categoryId, price, description);
   _productList.add(productModel);
    notifyListeners();
  }

  void updatePendingOrders(OrderModel order){
    _deliveryOrderList.add(order);
    _pendingOrderList.remove(order);
    ShowMessage("Send To Delivery");
    notifyListeners();
    

  }

  void updateCancelPendingOrder(OrderModel order){
_canceledOrderList.add(order);
 _pendingOrderList.remove(order);
  ShowMessage("Succesfully Cancel");
    notifyListeners();
  }

   void updateCancelDeliveryOrder(OrderModel order){
_canceledOrderList.add(order);
 _deliveryOrderList.remove(order);
 ShowMessage("Succesfully Cancel");
    notifyListeners();
  }
}