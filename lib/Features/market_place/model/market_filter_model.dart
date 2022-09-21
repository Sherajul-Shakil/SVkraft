// To parse this JSON data, do
//
//     final marketFilter = marketFilterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketFilter marketFilterFromJson(String str) =>
    MarketFilter.fromJson(json.decode(str));

String marketFilterToJson(MarketFilter data) => json.encode(data.toJson());

class MarketFilter {
  MarketFilter({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<MarketFilterdata> data;

  factory MarketFilter.fromJson(Map<String, dynamic> json) => MarketFilter(
        success: json["success"],
        message: json["message"],
        data: List<MarketFilterdata>.from(
            json["data"].map((x) => MarketFilterdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketFilterdata {
  MarketFilterdata({
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
  dynamic colors;
  String sizes;
  String location;
  String productCode;
  int inStock;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;
  List<MarketFilterImage> image;

  factory MarketFilterdata.fromJson(Map<String, dynamic> json) =>
      MarketFilterdata(
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
        image: List<MarketFilterImage>.from(
            json["image"].map((x) => MarketFilterImage.fromJson(x))),
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
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.image,
  });

  int id;
  String categoryName;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "image": image,
      };
}

class MarketFilterImage {
  MarketFilterImage({
    required this.filePath,
  });

  String filePath;

  factory MarketFilterImage.fromJson(Map<String, dynamic> json) =>
      MarketFilterImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}


// // To parse this JSON data, do
// //
// //     final marketFilter = marketFilterFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// MarketFilter marketFilterFromJson(String str) =>
//     MarketFilter.fromJson(json.decode(str));

// String marketFilterToJson(MarketFilter data) => json.encode(data.toJson());

// class MarketFilter {
//   MarketFilter({
//    required this.success,
//    required this.message,
//    required this.data,
//   });

//   bool success;
//   String message;
//   List<MarketFilterdata> data;

//   factory MarketFilter.fromJson(Map<String, dynamic> json) => MarketFilter(
//         success: json["success"],
//         message: json["message"],
//         data: List<MarketFilterdata>.from(
//             json["data"].map((x) => MarketFilterdata.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class MarketFilterdata {
//   MarketFilterdata({
//    required this.id,
//    required this.productName,
//    required this.description,
//    required this.price,
//    required this.quantity,
//    required this.colors,
//    required this.sizes,
//    required this.location,
//    required this.productCode,
//    required this.inStock,
//    required this.createdAt,
//    required this.updatedAt,
//    required this.category,
//    required this.image,
//   });

//   int id;
//   String productName;
//   String description;
//   int price;
//   int quantity;
//   String colors;
//   String sizes;
//   String location;
//   String productCode;
//   int inStock;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Category category;
//   List<MarketFilterMarketFilterImage> image;

//   factory MarketFilterdata.fromJson(Map<String, dynamic> json) =>
//       MarketFilterdata(
//         id: json["id"],
//         productName: json["product_name"],
//         description: json["description"],
//         price: json["price"],
//         quantity: json["quantity"],
//         colors: json["colors"],
//         sizes: json["sizes"],
//         location: json["location"],
//         productCode: json["product_code"],
//         inStock: json["in_stock"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         category: Category.fromJson(json["category"]),
//         image: List<MarketFilterMarketFilterImage>.from(
//             json["image"].map((x) => MarketFilterMarketFilterImage.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "description": description,
//         "price": price,
//         "quantity": quantity,
//         "colors": colors,
//         "sizes": sizes,
//         "location": location,
//         "product_code": productCode,
//         "in_stock": inStock,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "category": category.toJson(),
//         "image": List<dynamic>.from(image.map((x) => x.toJson())),
//       };

//   @override
//   String toString() {
//     return 'MarketFilterdata{id: $id, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, location: $location, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, category: $category, image: $image}';
//   }
// }

// class Category {
//   Category({
//    required this.categoryName,
//   });

//   String categoryName;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryName: json["category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//       };
// }

// class MarketFilterMarketFilterImage {
//   MarketFilterMarketFilterImage({
//    required this.filePath,
//   });

//   String filePath;

//   factory MarketFilterMarketFilterImage.fromJson(Map<String, dynamic> json) =>
//       MarketFilterMarketFilterImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }
