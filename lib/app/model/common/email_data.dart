// ignore_for_file: prefer_if_null_operators

class EmailData {
  EmailData({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.email,
    this.username,
    this.address1,
    this.address2,
    this.state,
    this.country,
    this.postalCode,
    this.phone,
    this.phoneType,
    this.locale,
    this.status,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? suffix;
  String? email;
  dynamic username;
  String? address1;
  String? address2;
  String? state;
  String? country;
  String? postalCode;
  String? phone;
  String? phoneType;
  String? locale;
  String? status;
  String? dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory EmailData.fromJson(Map<String, dynamic> json) => EmailData(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        suffix: json["suffix"] == null ? null : json["suffix"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"],
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        phone: json["phone"] == null ? null : json["phone"],
        phoneType: json["phone_type"] == null ? null : json["phone_type"],
        locale: json["locale"] == null ? null : json["locale"],
        status: json["status"] == null ? null : json["status"],
        dateOfBirth:
            json["date_of_birth"] == null ? null : json["date_of_birth"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "middle_name": middleName,
        "last_name": lastName == null ? null : lastName,
        "suffix": suffix == null ? null : suffix,
        "email": email == null ? null : email,
        "username": username,
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "postal_code": postalCode == null ? null : postalCode,
        "phone": phone == null ? null : phone,
        "phone_type": phoneType == null ? null : phoneType,
        "locale": locale == null ? null : locale,
        "status": status == null ? null : status,
        "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
