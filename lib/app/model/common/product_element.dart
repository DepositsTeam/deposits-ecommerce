// ignore_for_file: prefer_if_null_operators

import 'product.dart';

class ProductElement {
    ProductElement({
        this.id,
        this.productId,
        this.orderId,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    int? id;
    String? productId;
    String? orderId;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    ProductData? product;

    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : ProductData.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "order_id": orderId == null ? null : orderId,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "product": product == null ? null : product!.toJson(),
    };
}

