// ignore_for_file: prefer_if_null_operators

import 'meta.dart';

class CustomerData {
  CustomerData({
    this.clientId,
    this.id,
    this.merchantId,
    this.uuid,
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.meta,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  dynamic clientId;
  int? id;
  dynamic merchantId;
  String? uuid;
  String? email;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  Meta? meta;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        clientId: json["client_id"] == null ? null : json["client_id"],
        id: json["id"] == null ? null : json["id"],
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        gender: json["gender"] == null ? null : json["gender"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId ==null?null: clientId,
        "id": id == null ? null : id,
        "merchant_id": merchantId == null ? null : merchantId,
        "uuid": uuid == null ? null : uuid,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "middle_name": middleName,
        "last_name": lastName == null ? null : lastName,
        "gender": gender == null ? null : gender,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "meta": meta == null ? null : meta!.toJson(),
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
