// ignore_for_file: prefer_if_null_operators

class Pivot {
    Pivot({
        this.productId,
        this.assetId,
        this.sortId,
        this.createdAt,
        this.updatedAt,
    });

    String? productId;
    String? assetId;
    String? sortId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"] == null ? null : json["product_id"],
        assetId: json["asset_id"] == null ? null : json["asset_id"],
        sortId: json["sort_id"] == null ? null : json["sort_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "asset_id": assetId == null ? null : assetId,
        "sort_id": sortId == null ? null : sortId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
