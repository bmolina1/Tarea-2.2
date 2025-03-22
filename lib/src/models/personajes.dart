
import 'dart:convert';

Personajes personajesFromJson(String str) => Personajes.fromJson(json.decode(str));

String personajesToJson(Personajes data) => json.encode(data.toJson());

class Personajes {
    int id;
    String name;
    String status;
    String species;
    String gender;
    Origin origin;
    Location location;
    String image;

    Personajes({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.gender,
        required this.origin,
        required this.location,
        required this.image,
    });

    factory Personajes.fromJson(Map<String, dynamic> json) => Personajes(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        gender: json["gender"],
        origin: Origin.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
    };
}

class Origin {
    String name;

    Origin({
        required this.name,
    });

    factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Location {
    String name;
    String url;

    Location({
        required this.name,
        required this.url,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

