class Meta {
    Meta({
        this.address,
    });

    String? address;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
    };
}
