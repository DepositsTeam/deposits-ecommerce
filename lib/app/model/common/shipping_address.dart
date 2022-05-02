
// ignore_for_file: prefer_if_null_operators

class ShippingAddressData {
    ShippingAddressData({
        this.merchantId,
        this.zip,
        this.addressName,
        this.streetAddress,
        this.country,
        this.state,
        this.city,
        this.customerId,
        this.isDefaultAddress,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    dynamic merchantId;
    String? zip;
    String? streetAddress;
    String? addressName;
    String? country;
    String? state;
    String? city;
    String? customerId;
    String? isDefaultAddress;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory ShippingAddressData.fromJson(Map<String, dynamic> json) => ShippingAddressData(
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        zip: json["zip"] == null ? null : json["zip"],
        streetAddress: json["street_address"] == null ? null : json["street_address"],
        addressName: json["address_name"] == null ? null : json["address_name"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        isDefaultAddress: json["is_default_address"] == null ? null : json["is_default_address"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "merchant_id": merchantId == null ? null : merchantId,
        "zip": zip == null ? null : zip,
        "street_address": streetAddress == null ? null : streetAddress,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "customer_id": customerId == null ? null : customerId,
        "is_default_address": isDefaultAddress == null ? null : isDefaultAddress,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
    };
}
