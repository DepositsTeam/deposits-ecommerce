// To parse this JSON data, do
//
//     final ProductResponse = ProductResponseFromJson(jsonString);

import 'dart:convert';

import '../../../common/product.dart';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
    ProductResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    ProductData? data;

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

