// To parse this JSON data, do
//
//     final allOrdersResponse = allOrdersResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/order.dart';

AllOrdersResponse allOrdersResponseFromJson(String str) => AllOrdersResponse.fromJson(json.decode(str));

String allOrdersResponseToJson(AllOrdersResponse data) => json.encode(data.toJson());

class AllOrdersResponse {
    AllOrdersResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<OrderData>? data;

    factory AllOrdersResponse.fromJson(Map<String, dynamic> json) => AllOrdersResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}
