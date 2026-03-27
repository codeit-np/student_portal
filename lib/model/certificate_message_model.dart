class CertificateMessageModel {
    CertificateMessageModel({
        required this.success,
        required this.message,
    });

    final bool? success;
    final String? message;

    factory CertificateMessageModel.fromJson(Map<String, dynamic> json){ 
        return CertificateMessageModel(
            success: json["success"],
            message: json["message"],
        );
    }

}
