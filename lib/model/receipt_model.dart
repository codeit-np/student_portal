class ReceiptModel {
    ReceiptModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Datum> data;

    factory ReceiptModel.fromJson(Map<String, dynamic> json){ 
        return ReceiptModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.receiptId,
        required this.courseName,
        required this.amount,
        required this.enrolledDate,
        required this.download,
    });

    final int? receiptId;
    final String? courseName;
    final String? amount;
    final String? enrolledDate;
    final String? download;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            receiptId: json["receipt_id"],
            courseName: json["course_name"],
            amount: json["amount"],
            enrolledDate: json["enrolled_date"],
            download: json["download"],
        );
    }

}
