// To parse this JSON data, do
//
//     final findCustomerResponse = findCustomerResponseFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import '../../common/customer.dart';

FindCustomerResponse findCustomerResponseFromJson(String str) => FindCustomerResponse.fromJson(json.decode(str));

String findCustomerResponseToJson(FindCustomerResponse data) => json.encode(data.toJson());

class FindCustomerResponse {
    FindCustomerResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    CustomerData? data;

    factory FindCustomerResponse.fromJson(Map<String, dynamic> json) => FindCustomerResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : CustomerData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

