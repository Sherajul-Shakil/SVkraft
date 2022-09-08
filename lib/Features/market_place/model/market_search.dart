// To parse this JSON data, do
//
//     final marketSearch = marketSearchFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketSearch marketSearchFromJson(String str) =>
    MarketSearch.fromJson(json.decode(str));

String marketSearchToJson(MarketSearch data) => json.encode(data.toJson());

class MarketSearch {
  MarketSearch({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<mSearch> data;

  factory MarketSearch.fromJson(Map<String, dynamic> json) => MarketSearch(
        success: json["success"],
        message: json["message"],
        data: List<mSearch>.from(json["data"].map((x) => mSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class mSearch {
  mSearch({
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
    required this.category,
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
  Category category;
  List<MarketImage> image;

  factory mSearch.fromJson(Map<String, dynamic> json) => mSearch(
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
        category: Category.fromJson(json["category"]),
        image: List<MarketImage>.from(
            json["image"].map((x) => MarketImage.fromJson(x))),
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
        "category": category.toJson(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'mSearch{id: $id, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, location: $location, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, category: $category, image: $image}';
  }
}

class Category {
  Category({
    required this.categoryName,
  });

  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
      };
}

class MarketImage {
  MarketImage({
    required this.filePath,
  });

  String filePath;

  factory MarketImage.fromJson(Map<String, dynamic> json) => MarketImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}
