// To parse this JSON data, do
//
//     final getProductsResponse = getProductsResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/product.dart';


GetProductsResponse getProductsResponseFromJson(String str) => GetProductsResponse.fromJson(json.decode(str));

String getProductsResponseToJson(GetProductsResponse data) => json.encode(data.toJson());

class GetProductsResponse {
    GetProductsResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ProductData>? data;

    factory GetProductsResponse.fromJson(Map<String, dynamic> json) => GetProductsResponse(
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

