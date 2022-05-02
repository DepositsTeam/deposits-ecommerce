// To parse this JSON data, do
//
//     final allAssetsResponse = allAssetsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:deposits_ecommerce/app/model/common/asset.dart';

AllAssetsResponse allAssetsResponseFromJson(String str) => AllAssetsResponse.fromJson(json.decode(str));

String allAssetsResponseToJson(AllAssetsResponse data) => json.encode(data.toJson());

class AllAssetsResponse {
    AllAssetsResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<Asset>? data;

    factory AllAssetsResponse.fromJson(Map<String, dynamic> json) => AllAssetsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Asset>.from(json["data"].map((x) => Asset.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

