

// ignore_for_file: prefer_if_null_operators

import 'package:deposits_ecommerce/app/model/common/customer.dart';

import 'product.dart';

class OrderData {
    OrderData({
        this.id,
        this.uuid,
        this.amount,
        this.currency,
        this.transactionId,
        this.customerId,
        this.merchantId,
        this.shippingFee,
        this.dateFulfilled,
        this.country,
        this.state,
        this.city,
        this.streetAddress,
        this.zip,
        this.meta,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.products,
        this.customer,
    });

    int? id;
    String? uuid;
    String? amount;
    String? currency;
    String? transactionId;
    String? customerId;
    String? merchantId;
    String? shippingFee;
    dynamic dateFulfilled;
    String? country;
    String? state;
    String? city;
    String? streetAddress;
    String? zip;
    String? meta;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<ProductData>? products;
    CustomerData? customer;

    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        amount: json["amount"] == null ? null : json["amount"],
        currency: json["currency"] == null ? null : json["currency"],
        transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
        dateFulfilled: json["date_fulfilled"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        streetAddress: json["street_address"] == null ? null : json["street_address"],
        zip: json["zip"] == null ? null : json["zip"],
        meta: json["meta"] == null ? null : json["meta"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        products: json["products"] == null ? null : List<ProductData>.from(json["products"].map((x) => ProductData.fromJson(x))),
        customer: json["customer"] == null ? null : CustomerData.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "amount": amount == null ? null : amount,
        "currency": currency == null ? null : currency,
        "transaction_id": transactionId == null ? null : transactionId,
        "customer_id": customerId == null ? null : customerId,
        "merchant_id": merchantId == null ? null : merchantId,
        "shipping_fee": shippingFee == null ? null : shippingFee,
        "date_fulfilled": dateFulfilled,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "street_address": streetAddress == null ? null : streetAddress,
        "zip": zip == null ? null : zip,
        "meta": meta == null ? null : meta,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
        "customer": customer == null ? null : customer!.toJson(),
    };
}

