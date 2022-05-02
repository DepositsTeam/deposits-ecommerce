
// ignore_for_file: prefer_if_null_operators

class MerchantData {
    MerchantData({
        this.id,
        this.uuid,
        this.depositUserId,
        this.name,
        this.description,
        this.country,
        this.returnPolicy,
        this.shippingPolicy,
        this.fullRefund,
        this.shippingFee,
        this.taxPercent,
        this.taxId,
        this.contactAddress,
        this.contactInfo,
        this.state,
        this.city,
        this.streetAddress,
        this.zip,
        this.category,
        this.currency,
        this.supportEmail,
        this.logo,
        this.meta,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.walletAmount,
        this.walletAmountPending,
    });

    int? id;
    String? uuid;
    String? depositUserId;
    String? name;
    String? description;
    String? country;
    String? returnPolicy;
    String? shippingPolicy;
    dynamic fullRefund;
    dynamic shippingFee;
    dynamic taxPercent;
    dynamic taxId;
    dynamic contactAddress;
    dynamic contactInfo;
    String? state;
    String? city;
    String? streetAddress;
    String? zip;
    dynamic category;
    String? currency;
    String? supportEmail;
    String? logo;
    dynamic meta;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? walletAmount;
    String? walletAmountPending;

    factory MerchantData.fromJson(Map<String, dynamic> json) => MerchantData(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        depositUserId: json["deposit_user_id"] == null ? null : json["deposit_user_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        country: json["country"] == null ? null : json["country"],
        returnPolicy: json["return_policy"] == null ? null : json["return_policy"],
        shippingPolicy: json["shipping_policy"] == null ? null : json["shipping_policy"],
        fullRefund: json["full_refund"],
        shippingFee: json["shipping_fee"],
        taxPercent: json["tax_percent"],
        taxId: json["tax_id"],
        contactAddress: json["contact_address"],
        contactInfo: json["contact_info"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        streetAddress: json["street_address"] == null ? null : json["street_address"],
        zip: json["zip"] == null ? null : json["zip"],
        category: json["category"],
        currency: json["currency"] == null ? null : json["currency"],
        supportEmail: json["support_email"] == null ? null : json["support_email"],
        logo: json["logo"] == null ? null : json["logo"],
        meta: json["meta"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        walletAmount: json["wallet_amount"] == null ? null : json["wallet_amount"],
        walletAmountPending: json["wallet_amount_pending"] == null ? null : json["wallet_amount_pending"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "deposit_user_id": depositUserId == null ? null : depositUserId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "country": country == null ? null : country,
        "return_policy": returnPolicy == null ? null : returnPolicy,
        "shipping_policy": shippingFee == null ? null : shippingFee,
        "full_refund": fullRefund,
        "shipping_fee": shippingFee,
        "tax_percent": taxPercent,
        "tax_id": taxId,
        "contact_address": contactAddress,
        "contact_info": contactInfo,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "street_address": streetAddress == null ? null : streetAddress,
        "zip": zip == null ? null : zip,
        "category": category,
        "currency": currency == null ? null : currency,
        "support_email": supportEmail == null ? null : supportEmail,
        "logo": logo == null ? null : logo,
        "meta": meta,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "wallet_amount": walletAmount == null ? null : walletAmount,
        "wallet_amount_pending": walletAmountPending == null ? null : walletAmountPending,
    };
}
