class Member {
  String id;
  String firstname;
  String lastname;

  Member({
    this.id,
    this.firstname,
    this.lastname,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
      };
}
