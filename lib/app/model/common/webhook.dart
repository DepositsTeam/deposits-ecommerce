// ignore_for_file: prefer_if_null_operators

class WebHookData {
    WebHookData({
        this.id,
        this.merchantId,
        this.event,
        this.url,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? merchantId;
    String? event;
    String? url;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory WebHookData.fromJson(Map<String, dynamic> json) => WebHookData(
        id: json["id"] == null ? null : json["id"],
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        event: json["event"] == null ? null : json["event"],
        url: json["url"] == null ? null : json["url"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "merchant_id": merchantId == null ? null : merchantId,
        "event": event == null ? null : event,
        "url": url == null ? null : url,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}