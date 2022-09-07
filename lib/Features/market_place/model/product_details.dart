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
    required this.categoryId,
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.colors,
    required this.sizes,
    required this.productCode,
    required this.inStock,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  int categoryId;
  String productName;
  String description;
  int price;
  int quantity;
  String colors;
  String sizes;
  String productCode;
  int inStock;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductImage> image;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        id: json["id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        colors: json["colors"],
        sizes: json["sizes"],
        productCode: json["product_code"],
        inStock: json["in_stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: List<ProductImage>.from(
            json["image"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "product_name": productName,
        "description": description,
        "price": price,
        "quantity": quantity,
        "colors": colors,
        "sizes": sizes,
        "product_code": productCode,
        "in_stock": inStock,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return 'ProductDetailsData{id: $id, categoryId: $categoryId, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, image: $image},';
  }
}

class ProductImage {
  ProductImage({
    required this.filePath,
  });

  String filePath;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}
