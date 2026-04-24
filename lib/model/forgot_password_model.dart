class ForgotPasswordModel {
    ForgotPasswordModel({
        required this.success,
    });

    final bool? success;

    factory ForgotPasswordModel.fromJson(Map<String, dynamic> json){ 
        return ForgotPasswordModel(
            success: json["success"],
        );
    }

}
