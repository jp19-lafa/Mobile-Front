class IMember {
  String id;
  String firstname;
  String lastname;

  IMember({
    this.id,
    this.firstname,
    this.lastname,
  });

  factory IMember.fromJson(Map<String, dynamic> json) => IMember(
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
