// To parse this JSON data, do
//
//     final allProductResponse = allProductResponseFromJson(jsonString);

import 'dart:convert';

import '../../../common/product.dart';

AllProductResponse allProductResponseFromJson(String str) => AllProductResponse.fromJson(json.decode(str));

String allProductResponseToJson(AllProductResponse data) => json.encode(data.toJson());

class AllProductResponse {
    AllProductResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ProductData>? data;

    factory AllProductResponse.fromJson(Map<String, dynamic> json) => AllProductResponse(
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

