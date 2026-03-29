class TermsConditionModel {
    TermsConditionModel({
        required this.sucess,
        required this.data,
    });

    final bool? sucess;
    final String? data;

    factory TermsConditionModel.fromJson(Map<String, dynamic> json){ 
        return TermsConditionModel(
            sucess: json["sucess"],
            data: json["data"],
        );
    }

}
