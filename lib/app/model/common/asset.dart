// ignore_for_file: prefer_if_null_operators

import 'pivot.dart';

class Asset {
    Asset({
        this.id,
        this.merchantId,
        this.uuid,
        this.name,
        this.url,
        this.description,
        this.size,
        this.type,
        this.isImage,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    int? id;
    dynamic merchantId;
    String? uuid;
    String? name;
    String? url;
    dynamic description;
    dynamic size;
    String? type;
    String? isImage;
    String? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    Pivot? pivot;

    factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"] == null ? null : json["id"],
        merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"],
        size: json["size"] == null ? null : json["size"],
        type: json["type"] == null ? null : json["type"],
        isImage: json["is_image"] == null ? null : json["is_image"],
        status: json["status"] == null ? null : json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "merchant_id": merchantId == null ? null : merchantId,
        "uuid": uuid == null ? null : uuid,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "description": description,
        "size": size == null ? null : size,
        "type": type == null ? null : type,
        "is_image": isImage == null ? null : isImage,
        "status": status == null ? null : status,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "pivot": pivot == null ? null : pivot!.toJson(),
    };
}

