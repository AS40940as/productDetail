// To parse this JSON data, do
//
//     final Product = ProductFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String slug;
  String url;
  String title;
  String content;
  String image;
  String thumbnail;
  String status;
  String category;
  String publishedAt;
  String updatedAt;
  int userId;

  Product({
    required this.id,
    required this.slug,
    required this.url,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
    required this.status,
    required this.category,
    required this.publishedAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        url: json["url"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        category: json["category"],
        publishedAt: json["publishedAt"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "url": url,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
        "status": status,
        "category": category,
        "publishedAt": publishedAt,
        "updatedAt": updatedAt,
        "userId": userId,
      };
}
