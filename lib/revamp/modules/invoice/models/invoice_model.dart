import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';

SlotResponse slotResponseFromJson(String str) =>
    SlotResponse.fromJson(json.decode(str));

String slotResponseToJson(SlotResponse data) => json.encode(data.toJson());

class SlotResponse {
  SlotResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Payload payload;

  factory SlotResponse.fromJson(Map<String, dynamic> json) => SlotResponse(
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
    this.userId,
    this.slot,
    this.createdAt,
    this.updatedAt,
  });

  String userId;
  int slot;
  int createdAt;
  int updatedAt;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        userId: json["user_id"] == null ? null : json["user_id"],
        slot: json["slot"] == null ? null : json["slot"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "slot": slot == null ? null : slot,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

SlotPriceList slotPriceListFromJson(String str) =>
    SlotPriceList.fromJson(json.decode(str));

String slotPriceListToJson(SlotPriceList data) => json.encode(data.toJson());

class SlotPriceList {
  SlotPriceList({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  List<SlotPricePayload> payload;

  factory SlotPriceList.fromJson(Map<String, dynamic> json) => SlotPriceList(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : List<SlotPricePayload>.from(
                json["payload"].map((x) => SlotPricePayload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null
            ? null
            : List<dynamic>.from(payload.map((x) => x.toJson())),
      };
}

class SlotPricePayload {
  SlotPricePayload({
    this.slotId,
    this.slot,
    this.description,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String slotId;
  int slot;
  String description;
  int price;
  int status;
  int createdAt;
  int updatedAt;

  factory SlotPricePayload.fromJson(Map<String, dynamic> json) =>
      SlotPricePayload(
        slotId: json["slot_id"] == null ? null : json["slot_id"],
        slot: json["slot"] == null ? null : json["slot"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId == null ? null : slotId,
        "slot": slot == null ? null : slot,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

SlotPayment slotPaymentFromJson(String str) =>
    SlotPayment.fromJson(json.decode(str));

String slotPaymentToJson(SlotPayment data) => json.encode(data.toJson());

class SlotPayment {
  SlotPayment({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PaymentPayload payload;

  factory SlotPayment.fromJson(Map<String, dynamic> json) => SlotPayment(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : PaymentPayload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

SlotPaymentPayload slotPaymentPayloadFromJson(String str) =>
    SlotPaymentPayload.fromJson(json.decode(str));

String slotPaymentPayloadToJson(SlotPaymentPayload data) =>
    json.encode(data.toJson());

class SlotPaymentPayload {
  SlotPaymentPayload({
    this.slotId,
  });

  String slotId;

  factory SlotPaymentPayload.fromJson(Map<String, dynamic> json) =>
      SlotPaymentPayload(
        slotId: json["slot_id"] == null ? null : json["slot_id"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId == null ? null : slotId,
      };
}

HistorySlotResponse historySlotResponseFromJson(String str) =>
    HistorySlotResponse.fromJson(json.decode(str));

String historySlotResponseToJson(HistorySlotResponse data) =>
    json.encode(data.toJson());

class HistorySlotResponse {
  HistorySlotResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  HistorySlotList payload;

  factory HistorySlotResponse.fromJson(Map<String, dynamic> json) =>
      HistorySlotResponse(
        code: json["code"],
        message: json["message"],
        payload: HistorySlotList.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "payload": payload.toJson(),
      };
}

class HistorySlotList {
  HistorySlotList({
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
  List<RowHistorySlot> rows;

  factory HistorySlotList.fromJson(Map<String, dynamic> json) =>
      HistorySlotList(
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
            : List<RowHistorySlot>.from(
                json["rows"].map((x) => RowHistorySlot.fromJson(x))),
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

class RowHistorySlot {
  RowHistorySlot({
    this.transactionId,
    this.slotId,
    this.userId,
    this.slot,
    this.price,
    this.promoCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentData,
  });

  String transactionId;
  String slotId;
  String userId;
  int slot;
  int price;
  String promoCode;
  int status;
  int createdAt;
  int updatedAt;
  PaymentData paymentData;

  factory RowHistorySlot.fromJson(Map<String, dynamic> json) => RowHistorySlot(
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        slotId: json["slot_id"] == null ? null : json["slot_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        slot: json["slot"] == null ? null : json["slot"],
        price: json["price"] == null ? null : json["price"],
        promoCode: json["promo_code"] == null ? null : json["promo_code"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        paymentData: json["payment_data"] == null
            ? null
            : PaymentData.fromJson(json["payment_data"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId == null ? null : transactionId,
        "slot_id": slotId == null ? null : slotId,
        "user_id": userId == null ? null : userId,
        "slot": slot == null ? null : slot,
        "price": price == null ? null : price,
        "promo_code": promoCode == null ? null : promoCode,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "payment_data": paymentData == null ? null : paymentData.toJson(),
      };
}

class PaymentData {
  PaymentData({
    this.paymentCode,
    this.paymentBank,
    this.dueDate,
  });

  String paymentCode;
  dynamic paymentBank;
  dynamic dueDate;

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        paymentCode: json["payment_code"] == null ? null : json["payment_code"],
        paymentBank: json["payment_bank"] == null ? null : json["payment_bank"],
        dueDate: json["due_date"] == null ? null : json["due_date"],
      );

  Map<String, dynamic> toJson() => {
        "payment_code": paymentCode == null ? null : paymentCode,
        "payment_bank": paymentBank == null ? null : paymentBank,
        "due_date": dueDate == null ? null : dueDate,
      };
}

CreateInvoicePayload createInvoicePayloadFromJson(String str) =>
    CreateInvoicePayload.fromJson(json.decode(str));

String createInvoicePayloadToJson(CreateInvoicePayload data) =>
    json.encode(data.toJson());

class CreateInvoicePayload {
  CreateInvoicePayload({
    this.clientId,
    this.title,
    this.invoiceNumber,
    this.dueDate,
    this.tax,
    this.paymentStages,
    this.invoiceDetails,
  });

  String clientId;
  String title;
  String invoiceNumber;
  String dueDate;
  double tax;
  List<PaymentStage> paymentStages;
  List<InvoiceDetail> invoiceDetails;

  factory CreateInvoicePayload.fromJson(Map<String, dynamic> json) =>
      CreateInvoicePayload(
        clientId: json["client_id"] == null ? null : json["client_id"],
        title: json["title"] == null ? null : json["title"],
        invoiceNumber:
            json["invoice_number"] == null ? null : json["invoice_number"],
        dueDate: json["due_date"] == null ? null : json["due_date"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        paymentStages: json["payment_stages"] == null
            ? null
            : List<PaymentStage>.from(
                json["payment_stages"].map((x) => PaymentStage.fromJson(x))),
        invoiceDetails: json["invoice_details"] == null
            ? null
            : List<InvoiceDetail>.from(
                json["invoice_details"].map((x) => InvoiceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId == null ? null : clientId,
        "title": title == null ? null : title,
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "due_date": dueDate == null ? null : dueDate,
        "tax": tax == null ? null : tax,
        "payment_stages": paymentStages == null
            ? null
            : List<dynamic>.from(paymentStages.map((x) => x.toJson())),
        "invoice_details": invoiceDetails == null
            ? null
            : List<dynamic>.from(invoiceDetails.map((x) => x.toJson())),
      };
}

class InvoiceDetail {
  InvoiceDetail({
    this.title,
    this.description,
    this.quantity,
    this.price,
    this.amount,
  });

  String title;
  String description;
  int quantity;
  int price;
  int amount;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "amount": amount == null ? null : amount,
      };
}

class PaymentStage {
  PaymentStage({
    this.title,
    this.percentage,
    this.amount,
  });

  String title;
  int percentage;
  int amount;

  factory PaymentStage.fromJson(Map<String, dynamic> json) => PaymentStage(
        title: json["title"] == null ? null : json["title"],
        percentage: json["percentage"] == null ? null : json["percentage"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "percentage": percentage == null ? null : percentage,
        "amount": amount == null ? null : amount,
      };
}

CreateInvoiceResponse createInvoiceResponseFromJson(String str) =>
    CreateInvoiceResponse.fromJson(json.decode(str));

String createInvoiceResponseToJson(CreateInvoiceResponse data) =>
    json.encode(data.toJson());

class CreateInvoiceResponse {
  CreateInvoiceResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Payload payload;

  factory CreateInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      CreateInvoiceResponse(
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

class PayloadCreateInvoiceResponse {
  PayloadCreateInvoiceResponse({
    this.invoiceId,
    this.userId,
    this.clientId,
    this.title,
    this.invoiceNumber,
    this.dueDate,
    this.tax,
    this.amount,
    this.progress,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.invoiceDetail,
    this.clientDetail,
    this.paymentDetail,
  });

  String invoiceId;
  String userId;
  String clientId;
  String title;
  String invoiceNumber;
  int dueDate;
  double tax;
  int amount;
  List<dynamic> progress;
  int status;
  int createdAt;
  int updatedAt;
  List<InvoiceDetail> invoiceDetail;
  ClientDetail clientDetail;
  List<PaymentDetail> paymentDetail;

  factory PayloadCreateInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      PayloadCreateInvoiceResponse(
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        clientId: json["client_id"] == null ? null : json["client_id"],
        title: json["title"] == null ? null : json["title"],
        invoiceNumber:
            json["invoice_number"] == null ? null : json["invoice_number"],
        dueDate: json["due_date"] == null ? null : json["due_date"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        amount: json["amount"] == null ? null : json["amount"],
        progress: json["progress"] == null
            ? null
            : List<dynamic>.from(json["progress"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        invoiceDetail: json["invoice_detail"] == null
            ? null
            : List<InvoiceDetail>.from(
                json["invoice_detail"].map((x) => InvoiceDetail.fromJson(x))),
        clientDetail: json["client_detail"] == null
            ? null
            : ClientDetail.fromJson(json["client_detail"]),
        paymentDetail: json["payment_detail"] == null
            ? null
            : List<PaymentDetail>.from(
                json["payment_detail"].map((x) => PaymentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId == null ? null : invoiceId,
        "user_id": userId == null ? null : userId,
        "client_id": clientId == null ? null : clientId,
        "title": title == null ? null : title,
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "due_date": dueDate == null ? null : dueDate,
        "tax": tax == null ? null : tax,
        "amount": amount == null ? null : amount,
        "progress": progress == null
            ? null
            : List<dynamic>.from(progress.map((x) => x)),
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "invoice_detail": invoiceDetail == null
            ? null
            : List<dynamic>.from(invoiceDetail.map((x) => x.toJson())),
        "client_detail": clientDetail == null ? null : clientDetail.toJson(),
        "payment_detail": paymentDetail == null
            ? null
            : List<dynamic>.from(paymentDetail.map((x) => x.toJson())),
      };
}

class ClientDetail {
  ClientDetail({
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

  factory ClientDetail.fromJson(Map<String, dynamic> json) => ClientDetail(
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

class InvoiceDetailResponse {
  InvoiceDetailResponse({
    this.invoiceDetailId,
    this.invoiceId,
    this.userId,
    this.title,
    this.description,
    this.quantity,
    this.price,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  String invoiceDetailId;
  String invoiceId;
  dynamic userId;
  String title;
  String description;
  int quantity;
  int price;
  int amount;
  int createdAt;
  int updatedAt;

  factory InvoiceDetailResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailResponse(
        invoiceDetailId: json["invoice_detail_id"] == null
            ? null
            : json["invoice_detail_id"],
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_detail_id": invoiceDetailId == null ? null : invoiceDetailId,
        "invoice_id": invoiceId == null ? null : invoiceId,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "amount": amount == null ? null : amount,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class PaymentDetail {
  PaymentDetail({
    this.invoicePaymentId,
    this.invoiceId,
    this.title,
    this.percentage,
    this.amount,
    this.deduction,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentData,
  });

  String invoicePaymentId;
  String invoiceId;
  String title;
  int percentage;
  int amount;
  int deduction;
  int status;
  int createdAt;
  int updatedAt;
  dynamic paymentData;

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        invoicePaymentId: json["invoice_payment_id"] == null
            ? null
            : json["invoice_payment_id"],
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        title: json["title"] == null ? null : json["title"],
        percentage: json["percentage"] == null ? null : json["percentage"],
        amount: json["amount"] == null ? null : json["amount"],
        deduction: json["deduction"] == null ? null : json["deduction"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        paymentData: json["payment_data"] == null ? null : json["payment_data"],
      );

  Map<String, dynamic> toJson() => {
        "invoice_payment_id":
            invoicePaymentId == null ? null : invoicePaymentId,
        "invoice_id": invoiceId == null ? null : invoiceId,
        "title": title == null ? null : title,
        "percentage": percentage == null ? null : percentage,
        "amount": amount == null ? null : amount,
        "deduction": deduction == null ? null : deduction,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "payment_data": paymentData == null ? null : paymentData,
      };
}

PajakObj pajakObjFromJson(String str) => PajakObj.fromJson(json.decode(str));

String pajakObjToJson(PajakObj data) => json.encode(data.toJson());

class PajakObj {
  PajakObj({
    this.pajak,
    this.total,
  });

  double pajak;
  int total;

  factory PajakObj.fromJson(Map<String, dynamic> json) => PajakObj(
        pajak: json["pajak"] == null ? null : json["pajak"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "pajak": pajak == null ? null : pajak,
        "total": total == null ? null : total,
      };
}

GetAllInvoiceResponse getAllInvoiceResponseFromJson(String str) => GetAllInvoiceResponse.fromJson(json.decode(str));

String getAllInvoiceResponseToJson(GetAllInvoiceResponse data) => json.encode(data.toJson());

class GetAllInvoiceResponse {
    GetAllInvoiceResponse({
        this.code,
        this.message,
        this.payload,
    });

    String code;
    String message;
    GetAllInvoicePayload payload;

    factory GetAllInvoiceResponse.fromJson(Map<String, dynamic> json) => GetAllInvoiceResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null ? null : GetAllInvoicePayload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
    };
}

class GetAllInvoicePayload {
    GetAllInvoicePayload({
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
    List<GetAllInvoiceRow> rows;

    factory GetAllInvoicePayload.fromJson(Map<String, dynamic> json) => GetAllInvoicePayload(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage: json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null ? null : List<GetAllInvoiceRow>.from(json["rows"].map((x) => GetAllInvoiceRow.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
    };
}

class GetAllInvoiceRow {
    GetAllInvoiceRow({
        this.invoiceId,
        this.userId,
        this.clientId,
        this.title,
        this.invoiceNumber,
        this.dueDate,
        this.tax,
        this.amount,
        this.progress,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.invoiceDetail,
        this.clientDetail,
        this.paymentDetail,
    });

    String invoiceId;
    String userId;
    String clientId;
    String title;
    String invoiceNumber;
    int dueDate;
    double tax;
    int amount;
    List<dynamic> progress;
    int status;
    int createdAt;
    int updatedAt;
    List<InvoiceDetail> invoiceDetail;
    ClientDetail clientDetail;
    List<PaymentDetail> paymentDetail;

    factory GetAllInvoiceRow.fromJson(Map<String, dynamic> json) => GetAllInvoiceRow(
        invoiceId: json["invoice_id"] == null ? null : json["invoice_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        clientId: json["client_id"] == null ? null : json["client_id"],
        title: json["title"] == null ? null : json["title"],
        invoiceNumber: json["invoice_number"] == null ? null : json["invoice_number"],
        dueDate: json["due_date"] == null ? null : json["due_date"],
        tax: json["tax"] == null ? null : json["tax"].toDouble(),
        amount: json["amount"] == null ? null : json["amount"],
        progress: json["progress"] == null ? null : List<dynamic>.from(json["progress"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        invoiceDetail: json["invoice_detail"] == null ? null : List<InvoiceDetail>.from(json["invoice_detail"].map((x) => InvoiceDetail.fromJson(x))),
        clientDetail: json["client_detail"] == null ? null : ClientDetail.fromJson(json["client_detail"]),
        paymentDetail: json["payment_detail"] == null ? null : List<PaymentDetail>.from(json["payment_detail"].map((x) => PaymentDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId == null ? null : invoiceId,
        "user_id": userId == null ? null : userId,
        "client_id": clientId == null ? null : clientId,
        "title": title == null ? null : title,
        "invoice_number": invoiceNumber == null ? null : invoiceNumber,
        "due_date": dueDate == null ? null : dueDate,
        "tax": tax == null ? null : tax,
        "amount": amount == null ? null : amount,
        "progress": progress == null ? null : List<dynamic>.from(progress.map((x) => x)),
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "invoice_detail":  invoiceDetail == null ? null : List<dynamic>.from(invoiceDetail.map((x) => x.toJson())),
        "client_detail": clientDetail == null ? null : clientDetail.toJson(),
        "payment_detail": paymentDetail == null ? null : List<dynamic>.from(paymentDetail.map((x) => x.toJson())),
    };
}

GetStatisticResponse getStatisticResponseFromJson(String str) => GetStatisticResponse.fromJson(json.decode(str));

String getStatisticResponseToJson(GetStatisticResponse data) => json.encode(data.toJson());

class GetStatisticResponse {
    GetStatisticResponse({
        this.code,
        this.message,
        this.payload,
    });

    String code;
    String message;
    StatisticPayload payload;

    factory GetStatisticResponse.fromJson(Map<String, dynamic> json) => GetStatisticResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null ? null : StatisticPayload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
    };
}

class StatisticPayload {
    StatisticPayload({
        this.invoiceActive,
        this.paymentWaiting,
        this.paymentPaid,
    });

    int invoiceActive;
    int paymentWaiting;
    int paymentPaid;

    factory StatisticPayload.fromJson(Map<String, dynamic> json) => StatisticPayload(
        invoiceActive: json["invoice_active"] == null ? null : json["invoice_active"],
        paymentWaiting: json["payment_waiting"] == null ? null : json["payment_waiting"],
        paymentPaid: json["payment_paid"] == null ? null : json["payment_paid"],
    );

    Map<String, dynamic> toJson() => {
        "invoice_active": invoiceActive == null ? null : invoiceActive,
        "payment_waiting": paymentWaiting == null ? null : paymentWaiting,
        "payment_paid": paymentPaid == null ? null : paymentPaid,
    };
}