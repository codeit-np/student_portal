class CoursesModel {
    CoursesModel({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<Datum> data;

    factory CoursesModel.fromJson(Map<String, dynamic> json){ 
        return CoursesModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.enrollmentId,
        required this.courseId,
        required this.courseName,
        required this.courseImage,
        required this.mentorName,
        required this.lessons,
        required this.duration,
        required this.status,
    });

    final int? enrollmentId;
    final int? courseId;
    final String? courseName;
    final String? courseImage;
    final String? mentorName;
    final int? lessons;
    final String? duration;
    final String? status;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            enrollmentId: json["enrollment_id"],
            courseId: json["course_id"],
            courseName: json["course_name"],
            courseImage: json["course_image"],
            mentorName: json["mentor_name"],
            lessons: json["lessons"],
            duration: json["duration"],
            status: json["status"],
        );
    }

}
