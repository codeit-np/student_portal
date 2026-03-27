class CourseModel {
    CourseModel({
        required this.success,
        required this.courseDetails,
    });

    final bool? success;
    final CourseDetails? courseDetails;

    factory CourseModel.fromJson(Map<String, dynamic> json){ 
        return CourseModel(
            success: json["success"],
            courseDetails: json["course_details"] == null ? null : CourseDetails.fromJson(json["course_details"]),
        );
    }

}

class CourseDetails {
    CourseDetails({
        required this.enrollmentId,
        required this.course,
        required this.mentor,
        required this.videos,
    });

    final int? enrollmentId;
    final Course? course;
    final dynamic mentor;
    final List<Video> videos;

    factory CourseDetails.fromJson(Map<String, dynamic> json){ 
        return CourseDetails(
            enrollmentId: json["enrollment_id"],
            course: json["course"] == null ? null : Course.fromJson(json["course"]),
            mentor: json["mentor"],
            videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
        );
    }

}

class Course {
    Course({
        required this.id,
        required this.name,
        required this.image,
    });

    final int? id;
    final String? name;
    final String? image;

    factory Course.fromJson(Map<String, dynamic> json){ 
        return Course(
            id: json["id"],
            name: json["name"],
            image: json["image"],
        );
    }

}

class Video {
    Video({
        required this.id,
        required this.title,
        required this.videoId,
        required this.posted,
    });

    final int? id;
    final String? title;
    final String? videoId;
    final String? posted;

    factory Video.fromJson(Map<String, dynamic> json){ 
        return Video(
            id: json["id"],
            title: json["title"],
            videoId: json["videoId"],
            posted: json["posted"],
        );
    }

}
