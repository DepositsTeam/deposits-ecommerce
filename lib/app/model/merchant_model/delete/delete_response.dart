// To parse this JSON data, do
//
//     final deleteResponse = deleteResponseFromJson(jsonString);

import 'dart:convert';

DeleteResponse deleteResponseFromJson(String str) => DeleteResponse.fromJson(json.decode(str));

String deleteResponseToJson(DeleteResponse data) => json.encode(data.toJson());

class DeleteResponse {
    DeleteResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    dynamic data;

    factory DeleteResponse.fromJson(Map<String, dynamic> json) => DeleteResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
    };
}
