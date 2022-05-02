// To parse this JSON data, do
//
//     final getCustomerResponse = getCustomerResponseFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:deposits_ecommerce/app/common/utils/exports.dart';

GetCustomerResponse getCustomerResponseFromJson(String str) =>
    GetCustomerResponse.fromJson(json.decode(str));

String getCustomerResponseToJson(GetCustomerResponse data) =>
    json.encode(data.toJson());

class GetCustomerResponse {
  GetCustomerResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  CustomerData? data;

  factory GetCustomerResponse.fromJson(Map<String, dynamic> json) =>
      GetCustomerResponse(
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

