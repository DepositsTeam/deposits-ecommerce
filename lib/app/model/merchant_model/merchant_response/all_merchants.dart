import 'dart:convert';

import '../../common/merchant.dart';

AllMerchantsResponse allMerchantsResponseFromJson(String str) =>
    AllMerchantsResponse.fromJson(json.decode(str));

String allMerchantsResponseToJson(AllMerchantsResponse data) =>
    json.encode(data.toJson());

class AllMerchantsResponse {
  AllMerchantsResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<MerchantData>? data;

  factory AllMerchantsResponse.fromJson(Map<String, dynamic> json) =>
      AllMerchantsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<MerchantData>.from(json["data"].map((x) => MerchantData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
