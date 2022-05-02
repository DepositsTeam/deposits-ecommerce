// To parse this JSON data, do
//
//     final supportResponse = supportResponseFromJson(jsonString);

import 'dart:convert';

SupportResponse supportResponseFromJson(String str) => SupportResponse.fromJson(json.decode(str));

String supportResponseToJson(SupportResponse data) => json.encode(data.toJson());

class SupportResponse {
    SupportResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory SupportResponse.fromJson(Map<String, dynamic> json) => SupportResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.merchantId,
        this.orderId,
        this.category,
        this.description,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int? merchantId;
    String? orderId;
    String? category;
    String? description;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        category: json["category"] == null ? null : json["category"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "merchant_id": merchantId == null ? null : merchantId,
        "order_id": orderId == null ? null : orderId,
        "category": category == null ? null : category,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
    };
}
