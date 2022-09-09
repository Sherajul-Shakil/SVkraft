// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  ProductDetailsData data;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        success: json["success"],
        message: json["message"],
        data: ProductDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ProductDetailsData {
  ProductDetailsData({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.colors,
    required this.sizes,
    required this.location,
    required this.productCode,
    required this.inStock,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  String productName;
  String description;
  int price;
  int quantity;
  String colors;
  String sizes;
  String location;
  String productCode;
  int inStock;
  DateTime createdAt;
  DateTime updatedAt;
  List<DetailsImage> image;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        colors: json["colors"],
        sizes: json["sizes"],
        location: json["location"],
        productCode: json["product_code"],
        inStock: json["in_stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: List<DetailsImage>.from(
            json["image"].map((x) => DetailsImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "price": price,
        "quantity": quantity,
        "colors": colors,
        "sizes": sizes,
        "location": location,
        "product_code": productCode,
        "in_stock": inStock,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
  @override
  String toString() {
    // TODO: implement toString
    return 'ProductDetailsData{id: $id, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, location: $location, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, image: $image}';
  }
}

class DetailsImage {
  DetailsImage({
    required this.filePath,
  });

  String filePath;

  factory DetailsImage.fromJson(Map<String, dynamic> json) => DetailsImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}
