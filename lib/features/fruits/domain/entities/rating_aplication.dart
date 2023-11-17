class RatingAplicationEntity {
    final double rating;
    final String comment;


    RatingAplicationEntity({
        required this.rating,
        required this.comment,
    });

    factory RatingAplicationEntity.fromJson(Map<String, dynamic> json) => RatingAplicationEntity(
        rating: json["rating"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
    };
}
