// To parse this JSON data, do
//
//     final setupMerchantResponse = setupMerchantResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/merchant.dart';

SetupMerchantResponse setupMerchantResponseFromJson(String str) => SetupMerchantResponse.fromJson(json.decode(str));

String setupMerchantResponseToJson(SetupMerchantResponse data) => json.encode(data.toJson());

class SetupMerchantResponse {
    SetupMerchantResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    MerchantData? data;

    factory SetupMerchantResponse.fromJson(Map<String, dynamic> json) => SetupMerchantResponse(
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

// class Data {
//     Data({
//         this.uuid,
//         this.depositUserId,
//         this.name,
//         this.description,
//         this.country,
//         this.currency,
//         this.supportEmail,
//         this.logo,
//         this.zip,
//         this.streetAddress,
//         this.state,
//         this.city,
//         this.status,
//         this.updatedAt,
//         this.createdAt,
//         this.id,
//         this.walletAmount,
//         this.walletAmountPending,
//     });

//     String? uuid;
//     String? depositUserId;
//     String? name;
//     String? description;
//     String? country;
//     String? currency;
//     String? supportEmail;
//     String? logo;
//     String? zip;
//     String? streetAddress;
//     String? state;
//     String? city;
//     String? status;
//     DateTime? updatedAt;
//     DateTime? createdAt;
//     int? id;
//     String? walletAmount;
//     String? walletAmountPending;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         uuid: json["uuid"] == null ? null : json["uuid"],
//         depositUserId: json["deposit_user_id"] == null ? null : json["deposit_user_id"],
//         name: json["name"] == null ? null : json["name"],
//         description: json["description"] == null ? null : json["description"],
//         country: json["country"] == null ? null : json["country"],
//         currency: json["currency"] == null ? null : json["currency"],
//         supportEmail: json["support_email"] == null ? null : json["support_email"],
//         logo: json["logo"] == null ? null : json["logo"],
//         zip: json["zip"] == null ? null : json["zip"],
//         streetAddress: json["street_address"] == null ? null : json["street_address"],
//         state: json["state"] == null ? null : json["state"],
//         city: json["city"] == null ? null : json["city"],
//         status: json["status"] == null ? null : json["status"],
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         id: json["id"] == null ? null : json["id"],
//         walletAmount: json["wallet_amount"] == null ? null : json["wallet_amount"],
//         walletAmountPending: json["wallet_amount_pending"] == null ? null : json["wallet_amount_pending"],
//     );

//     Map<String, dynamic> toJson() => {
//         "uuid": uuid == null ? null : uuid,
//         "deposit_user_id": depositUserId == null ? null : depositUserId,
//         "name": name == null ? null : name,
//         "description": description == null ? null : description,
//         "country": country == null ? null : country,
//         "currency": currency == null ? null : currency,
//         "support_email": supportEmail == null ? null : supportEmail,
//         "logo": logo == null ? null : logo,
//         "zip": zip == null ? null : zip,
//         "street_address": streetAddress == null ? null : streetAddress,
//         "state": state == null ? null : state,
//         "city": city == null ? null : city,
//         "status": status == null ? null : status,
//         "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//         "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//         "id": id == null ? null : id,
//         "wallet_amount": walletAmount == null ? null : walletAmount,
//         "wallet_amount_pending": walletAmountPending == null ? null : walletAmountPending,
//     };
// }
