// To parse this JSON data, do
//
//     final getMerchantEmailResponse = getMerchantEmailResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/email_data.dart';

GetMerchantEmailResponse getMerchantEmailResponseFromJson(String str) =>
    GetMerchantEmailResponse.fromJson(json.decode(str));

String getMerchantEmailResponseToJson(GetMerchantEmailResponse data) =>
    json.encode(data.toJson());

class GetMerchantEmailResponse {
  GetMerchantEmailResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  EmailData? data;

  factory GetMerchantEmailResponse.fromJson(Map<String, dynamic> json) =>
      GetMerchantEmailResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : EmailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

