// To parse this JSON data, do
//
//     final AssetsResponse = AssetsResponseFromJson(jsonString);

import 'dart:convert';

import '../../../common/asset.dart';

AssetsResponse assetsResponseFromJson(String str) => AssetsResponse.fromJson(json.decode(str));

String assetsResponseToJson(AssetsResponse data) => json.encode(data.toJson());

class AssetsResponse {
    AssetsResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Asset? data;

    factory AssetsResponse.fromJson(Map<String, dynamic> json) => AssetsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Asset.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

