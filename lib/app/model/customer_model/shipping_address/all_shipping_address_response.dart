// To parse this JSON data, do
//
//     final allShippingAddressResponse = allShippingAddressResponseFromJson(jsonString);

import 'dart:convert';

import 'package:deposits_ecommerce/app/model/common/shipping_address.dart';

AllShippingAddressResponse allShippingAddressResponseFromJson(String str) => AllShippingAddressResponse.fromJson(json.decode(str));

String allShippingAddressResponseToJson(AllShippingAddressResponse data) => json.encode(data.toJson());

class AllShippingAddressResponse {
    AllShippingAddressResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ShippingAddressData>? data;

    factory AllShippingAddressResponse.fromJson(Map<String, dynamic> json) => AllShippingAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<ShippingAddressData>.from(json["data"].map((x) => ShippingAddressData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}
