// ignore_for_file: prefer_if_null_operators

import 'package:deposits_ecommerce/app/model/common/order.dart';

import 'asset.dart';

class ProductData {
    ProductData({
        this.id,
        this.merchantId,
        this.uuid,
        this.name,
        this.sku,
        this.price,
        this.description,
        this.quantity,
        this.thankYouUrl,
        this.categoryId,
        this.sortOrder,
        this.shippingFee,
        this.tax,
        this.type,
        this.meta,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.numberSold,
        this.assets,
        this.orders,
    });

    int? id;
    String? merchantId;
    String? uuid;
    String? name;
    String? sku;
    String? price;
    String? description;
    String? quantity;
    String? thankYouUrl;
    dynamic categoryId;
    String? sortOrder;
    dynamic shippingFee;
    dynamic tax;
    String? type;
    String? meta;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? numberSold;
    List<Asset>? assets;
    List<OrderData>? orders;

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"] == null ? null : json["id"],
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        name: json["name"] == null ? null : json["name"],
        sku: json["sku"] == null ? null : json["sku"],
        price: json["price"] == null ? null : json["price"],
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        thankYouUrl: json["thank_you_url"] == null ? null : json["thank_you_url"],
        categoryId: json["category_id"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        shippingFee: json["shipping_fee"],
        tax: json["tax"],
        type: json["type"] == null ? null : json["type"],
        meta: json["meta"] == null ? null : json["meta"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        numberSold: json["number_sold"] == null ?  null : json["number_sold"],
        assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
        orders: json["orders"] == null ? null : List<OrderData>.from(json["orders"].map((x) => OrderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "merchant_id": merchantId == null ? null : merchantId,
        "uuid": uuid == null ? null : uuid,
        "name": name == null ? null : name,
        "sku": sku == null ? null : sku,
        "price": price == null ? null : price,
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
        "thank_you_url": thankYouUrl == null ? null : thankYouUrl,
        "category_id": categoryId,
        "sort_order": sortOrder == null ? null : sortOrder,
        "shipping_fee": shippingFee,
        "tax": tax,
        "type": type == null ? null : type,
        "meta": meta == null ? null : meta,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "number_sold":numberSold == null ? null : numberSold,
        "assets": assets == null ? null : List<dynamic>.from(assets!.map((x) => x.toJson())),
        "orders": orders == null ? null : List<dynamic>.from(orders!.map((x) => x.toJson())),
    };
}
