// To parse this JSON data, do
//
//     final singleProductResponse = singleProductResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/product.dart';

SingleProductResponse singleProductResponseFromJson(String str) => SingleProductResponse.fromJson(json.decode(str));

String singleProductResponseToJson(SingleProductResponse data) => json.encode(data.toJson());

class SingleProductResponse {
    SingleProductResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    ProductData? data;

    factory SingleProductResponse.fromJson(Map<String, dynamic> json) => SingleProductResponse(
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

