class CertificateModel {
    CertificateModel({
        required this.sucess,
        required this.data,
    });

    final bool? sucess;
    final List<Datum> data;

    factory CertificateModel.fromJson(Map<String, dynamic> json){ 
        return CertificateModel(
            sucess: json["sucess"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.certicateId,
        required this.courseName,
        required this.issuedTo,
        required this.courseCompletionDate,
        required this.downloadCertificate,
    });

    final int? certicateId;
    final String? courseName;
    final String? issuedTo;
    final String? courseCompletionDate;
    final String? downloadCertificate;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            certicateId: json["certicate_id"],
            courseName: json["course_name"],
            issuedTo: json["Issued to"],
            courseCompletionDate: json["course_completion_Date"],
            downloadCertificate: json["download_Certificate"],
        );
    }

}
