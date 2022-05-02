// To parse this JSON data, do
//
//     final orderCheckoutResponse = orderCheckoutResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/order.dart';

OrderCheckoutResponse orderCheckoutResponseFromJson(String str) => OrderCheckoutResponse.fromJson(json.decode(str));

String orderCheckoutResponseToJson(OrderCheckoutResponse data) => json.encode(data.toJson());

class OrderCheckoutResponse {
    OrderCheckoutResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    OrderData? data;

    factory OrderCheckoutResponse.fromJson(Map<String, dynamic> json) => OrderCheckoutResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : OrderData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

