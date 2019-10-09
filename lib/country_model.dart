class CountryModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  CountryModel({this.id, this.title,this.description,this.imageUrl});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return new CountryModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageURL'],
    );
  }

  factory CountryModel.fromMap(Map map) {
    return new CountryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "imageUrl": imageUrl
  };
}
