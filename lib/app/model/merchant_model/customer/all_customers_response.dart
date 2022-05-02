// To parse this JSON data, do
//
//     final allCustomersResponse = allCustomersResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/customer.dart';

AllCustomersResponse allCustomersResponseFromJson(String str) =>
    AllCustomersResponse.fromJson(json.decode(str));

String allCustomersResponseToJson(AllCustomersResponse data) =>
    json.encode(data.toJson());

class AllCustomersResponse {
  AllCustomersResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<CustomerData>? data;

  factory AllCustomersResponse.fromJson(Map<String, dynamic> json) =>
      AllCustomersResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<CustomerData>.from(json["data"].map((x) => CustomerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
