class Promotion {
  String title;
  String description;
  String type;
  String partenaire;

  Promotion(this.title, this.description, this.type, this.partenaire);

  Promotion.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        type = json['type'],
        partenaire = json['partenaire'];
}
