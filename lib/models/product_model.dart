import 'dart:convert';

ProductModel productModelFromJson(String str) =>
 ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
 json.encode(data.toJson());

class ProductModel{
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.isFavorite,
    this.count
  });
String image;
String id,categoryId;
bool isFavorite;
String name;
double price;
String description;

int? count;
 
 factory ProductModel.fromJson(Map<String, dynamic> json)=> ProductModel(
  id: json["id"].toString(),
  name: json["name"],
  categoryId: json["categoryId"]??"",
  price: double.parse(json["price"].toString()),
  description: json["description"],
  image: json["image"],
  isFavorite: false,
  count : json["count"]
  );

 Map<String,dynamic> toJson() => {
  "id": id,
  "name": name,
  "price": price,
  "description": description,
  "image":image,
  "isFavorite": isFavorite,
  "count" : count,
  "categoryId":categoryId
 } ;

ProductModel copyWith({
String? name,
String? image,
String? id,
String? categoryId,
String? description,
String? price
  }) =>
  ProductModel(
  id: id ?? this.id,
  name: name ?? this.name,
  price: price !=null ? double.parse(price):this.price,
  description: description ?? this.description,
  image: image ?? this.image,
  categoryId: categoryId ?? this.categoryId,
  isFavorite: false,
  count: 1
  
  
      );

}