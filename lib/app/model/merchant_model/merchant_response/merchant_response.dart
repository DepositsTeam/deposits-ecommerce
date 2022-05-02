// To parse this JSON data, do
//
//     final getSingleMerchantResponse = getSingleMerchantResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/merchant.dart';

GetSingleMerchantResponse getSingleMerchantResponseFromJson(String str) => GetSingleMerchantResponse.fromJson(json.decode(str));

String getSingleMerchantResponseToJson(GetSingleMerchantResponse data) => json.encode(data.toJson());

class GetSingleMerchantResponse {
    GetSingleMerchantResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    MerchantData? data;

    factory GetSingleMerchantResponse.fromJson(Map<String, dynamic> json) => GetSingleMerchantResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : MerchantData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}
