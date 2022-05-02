// To parse this JSON data, do
//
//     final featuredProductsResponse = featuredProductsResponseFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import '../../common/product.dart';



FeaturedProductsResponse featuredProductsResponseFromJson(String str) => FeaturedProductsResponse.fromJson(json.decode(str));

String featuredProductsResponseToJson(FeaturedProductsResponse data) => json.encode(data.toJson());

class FeaturedProductsResponse {
    FeaturedProductsResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ProductData>? data;

    factory FeaturedProductsResponse.fromJson(Map<String, dynamic> json) => FeaturedProductsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<ProductData>.from(json["data"].map((x) => ProductData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

