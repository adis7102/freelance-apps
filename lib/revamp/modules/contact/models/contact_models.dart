import 'dart:convert';

ListKontakResponse listKontakResponseFromJson(String str) =>
    ListKontakResponse.fromJson(json.decode(str));

String listKontakResponseToJson(ListKontakResponse data) =>
    json.encode(data.toJson());

class ListKontakResponse {
  ListKontakResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Payload payload;

  factory ListKontakResponse.fromJson(Map<String, dynamic> json) =>
      ListKontakResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class Payload {
  Payload({
    this.total,
    this.totalPage,
    this.rowPerPage,
    this.previousPage,
    this.nextPage,
    this.currentPage,
    this.info,
    this.rows,
  });

  int total;
  int totalPage;
  int rowPerPage;
  int previousPage;
  int nextPage;
  int currentPage;
  String info;
  List<ClientData> rows;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage:
            json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null
            ? null
            : List<ClientData>.from(
                json["rows"].map((x) => ClientData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class ClientData {
  ClientData({
    this.clientId,
    this.name,
    this.representativeName,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  String clientId;
  String name;
  String representativeName;
  String email;
  String phone;
  int createdAt;
  int updatedAt;

  factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
        clientId: json["client_id"] == null ? null : json["client_id"],
        name: json["name"] == null ? null : json["name"],
        representativeName: json["representative_name"] == null
            ? null
            : json["representative_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId == null ? null : clientId,
        "name": name == null ? null : name,
        "representative_name":
            representativeName == null ? null : representativeName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

CreateContactResponse createContactResponseFromJson(String str) =>
    CreateContactResponse.fromJson(json.decode(str));

String createContactResponseToJson(CreateContactResponse data) =>
    json.encode(data.toJson());

class CreateContactResponse {
  CreateContactResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  CreateClientResponsePayload payload;

  factory CreateContactResponse.fromJson(Map<String, dynamic> json) =>
      CreateContactResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null ? null : CreateClientResponsePayload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class CreateClientResponsePayload {
  CreateClientResponsePayload({
    this.createdAt,
    this.updatedAt,
    this.clientId,
    this.name,
    this.representativeName,
    this.phone,
    this.email,
  });

  int createdAt;
  int updatedAt;
  String clientId;
  String name;
  String representativeName;
  String phone;
  String email;

  factory CreateClientResponsePayload.fromJson(Map<String, dynamic> json) =>
      CreateClientResponsePayload(
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        clientId: json["client_id"] == null ? null : json["client_id"],
        name: json["name"] == null ? null : json["name"],
        representativeName: json["representative_name"] == null ? null : json["representative_name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "client_id": clientId == null ? null : clientId,
        "name": name == null ? null : name,
        "representative_name": representativeName == null ? null : representativeName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
      };
}

CreateContactPayload createContactPayloadFromJson(String str) =>
    CreateContactPayload.fromJson(json.decode(str));

String createContactPayloadToJson(CreateContactPayload data) =>
    json.encode(data.toJson());

class CreateContactPayload {
  CreateContactPayload({
    this.name,
    this.representativeName,
    this.phone,
    this.email,
  });

  String name;
  String representativeName;
  String phone;
  String email;

  factory CreateContactPayload.fromJson(Map<String, dynamic> json) =>
      CreateContactPayload(
        name: json["name"] == null ? null : json["name"],
        representativeName: json["representative_name"] == null
            ? null
            : json["representative_name"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "representative_name":
            representativeName == null ? null : representativeName,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
      };
}

DeleteContactResponse deleteContactResponseFromJson(String str) => DeleteContactResponse.fromJson(json.decode(str));

String deleteContactResponseToJson(DeleteContactResponse data) => json.encode(data.toJson());

class DeleteContactResponse {
    DeleteContactResponse({
        this.code,
        this.message,
        this.payload,
    });

    String code;
    String message;
    DeleteClientPayload payload;

    factory DeleteContactResponse.fromJson(Map<String, dynamic> json) => DeleteContactResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null ? null : DeleteClientPayload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
    };
}

class DeleteClientPayload {
    DeleteClientPayload({
        this.clientId,
        this.name,
        this.representativeName,
        this.email,
        this.phone,
        this.createdAt,
        this.updatedAt,
    });

    String clientId;
    String name;
    String representativeName;
    String email;
    String phone;
    int createdAt;
    int updatedAt;

    factory DeleteClientPayload.fromJson(Map<String, dynamic> json) => DeleteClientPayload(
        clientId: json["client_id"] == null ? null : json["client_id"],
        name: json["name"] == null ? null : json["name"],
        representativeName: json["representative_name"] == null ? null : json["representative_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "client_id": clientId == null ? null : clientId,
        "name": name == null ? null : name,
        "representative_name": representativeName == null ? null : representativeName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
    };
}

EditContactResponse editContactResponseFromJson(String str) => EditContactResponse.fromJson(json.decode(str));

String editContactResponseToJson(EditContactResponse data) => json.encode(data.toJson());

class EditContactResponse {
    EditContactResponse({
        this.code,
        this.message,
        this.payload,
    });

    String code;
    String message;
    EditContactPayload payload;

    factory EditContactResponse.fromJson(Map<String, dynamic> json) => EditContactResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null ? null : EditContactPayload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
    };
}

class EditContactPayload {
    EditContactPayload({
        this.clientId,
        this.name,
        this.representativeName,
        this.email,
        this.phone,
        this.createdAt,
        this.updatedAt,
    });

    String clientId;
    String name;
    String representativeName;
    String email;
    String phone;
    int createdAt;
    int updatedAt;

    factory EditContactPayload.fromJson(Map<String, dynamic> json) => EditContactPayload(
        clientId: json["client_id"] == null ? null : json["client_id"],
        name: json["name"] == null ? null : json["name"],
        representativeName: json["representative_name"] == null ? null : json["representative_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "client_id": clientId == null ? null : clientId,
        "name": name == null ? null : name,
        "representative_name": representativeName == null ? null : representativeName,
        "email": email == null ? null : phone,
        "phone": phone == null ? null : phone,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
    };
}