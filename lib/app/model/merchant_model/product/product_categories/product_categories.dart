// To parse this JSON data, do
//
//     final productCategoryResponse = productCategoryResponseFromJson(jsonString);

import 'dart:convert';

ProductCategoryResponse productCategoryResponseFromJson(String str) => ProductCategoryResponse.fromJson(json.decode(str));

String productCategoryResponseToJson(ProductCategoryResponse data) => json.encode(data.toJson());

class ProductCategoryResponse {
    ProductCategoryResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<String>? data;

    factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) => ProductCategoryResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
    };
}
