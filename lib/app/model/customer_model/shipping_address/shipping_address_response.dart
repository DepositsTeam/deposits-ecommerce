// To parse this JSON data, do
//
//     final shippingAddressResponse = shippingAddressResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/shipping_address.dart';

ShippingAddressResponse shippingAddressResponseFromJson(String str) => ShippingAddressResponse.fromJson(json.decode(str));

String shippingAddressResponseToJson(ShippingAddressResponse data) => json.encode(data.toJson());

class ShippingAddressResponse {
    ShippingAddressResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    ShippingAddressData? data;

    factory ShippingAddressResponse.fromJson(Map<String, dynamic> json) => ShippingAddressResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ShippingAddressData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}
