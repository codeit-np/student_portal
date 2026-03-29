class GooglemeetModel {
    GooglemeetModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Datum> data;

    factory GooglemeetModel.fromJson(Map<String, dynamic> json){ 
        return GooglemeetModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.courseName,
        required this.mentorName,
        required this.classTime,
        required this.meetLink,
    });

    final int? id;
    final String? courseName;
    final String? mentorName;
    final String? classTime;
    final String? meetLink;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            courseName: json["course_name"],
            mentorName: json["mentor_name"],
            classTime: json["class_time"],
            meetLink: json["meet_link"],
        );
    }

}
