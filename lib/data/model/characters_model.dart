class CharactersModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? gender;
  String? image;
  String? url;
  List<String>? episode;
  Origin? origin;
  Location? location;
  String? created;
  CharactersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    created = json['created'];
    url = json['url'];
    episode = json['episode'].cast<String>();
    origin = Origin.fromJson(json['origin']);
    location = Location.fromJson(json['location']);
  }
}

class Origin {
  String? name;
  String? url;
  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Location {
  String? name;
  String? url;
  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
