// To parse this JSON data, do
//
//     final createCustomerResponse = createCustomerResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/customer.dart';

CreateCustomerResponse createCustomerResponseFromJson(String str) =>
    CreateCustomerResponse.fromJson(json.decode(str));

String createCustomerResponseToJson(CreateCustomerResponse data) =>
    json.encode(data.toJson());

class CreateCustomerResponse {
  CreateCustomerResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  CustomerData? data;

  factory CreateCustomerResponse.fromJson(Map<String, dynamic> json) =>
      CreateCustomerResponse(
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

