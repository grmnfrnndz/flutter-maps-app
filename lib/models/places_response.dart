// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.textEs,
        required this.placeNameEs,
        required this.text,
        this.language,
        required this.placeName,
        required this.center,
        required this.geometry,
        required this.context,
    });

    final String id;
    final String type;
    final List<String> placeType;
    final Properties properties;
    final String textEs;
    final String placeNameEs;
    final String text;
    final String? language;
    final String placeName;
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toMap(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
    };

    @override
  String toString() {
    // TODO: implement toString
    return 'Feature: $text';
  }
}

class Context {
    Context({
        required this.id,
        this.shortCode,
        this.wikidata,
        required this.textEs,
        this.languageEs,
        required this.text,
        this.language,
    });

    final String id;
    final ShortCode? shortCode;
    final String? wikidata;
    final String textEs;
    final String? languageEs;
    final String text;
    final String? language;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        shortCode: json["short_code"] == null ? null : shortCodeValues.map[json["short_code"]],
        wikidata: json["wikidata"],
        textEs: json["text_es"],
        text: json["text"],
        language: json["language"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "short_code": shortCode == null ? null : shortCodeValues.reverse[shortCode],
        "wikidata": wikidata,
        "text_es": textEs,
        "text": text,
        "language": language,
    };
}


enum ShortCode { CL_BI, CL }

final shortCodeValues = EnumValues({
    "cl": ShortCode.CL,
    "CL-BI": ShortCode.CL_BI
});

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
    });

    final String type;
    final List<double> coordinates;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    Properties({
        this.wikidata,
        this.category,
        this.landmark,
        this.address,
        this.foursquare,
        this.maki,
    });

    final String? wikidata;
    final String? category;
    final bool? landmark;
    final String? address;
    final String? foursquare;
    final String? maki;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        category: json["category"],
        landmark: json["landmark"],
        address: json["address"],
        foursquare: json["foursquare"],
        maki: json["maki"],
    );

    Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
        "category": category,
        "landmark": landmark,
        "address": address,
        "foursquare": foursquare,
        "maki": maki,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}
