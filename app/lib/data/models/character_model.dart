class Character {
  final int id;
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  final String originName;
  final String locationName;
  final List<String> episodeUrls;

  const Character({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
    required this.status,
    required this.originName,
    required this.locationName,
    required this.episodeUrls,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      species: json['species'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      status: json['status'] as String? ?? '',
      originName: (json['origin']?['name'] as String?) ?? '',
      locationName: (json['location']?['name'] as String?) ?? '',
      episodeUrls: (json['episode'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
