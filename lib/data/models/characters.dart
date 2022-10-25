class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusDeadORLife;
  late List<dynamic> apperanceOfSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> betterToCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusDeadORLife = json["status"];
    apperanceOfSeasons = json["appearance"];
    actorName = json["portrayed"];
    categoryForTwoSeries = json["category"];
    betterToCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
