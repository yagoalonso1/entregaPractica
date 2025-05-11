// clase que contiene los atributos de un personaje;
class Character {
  final String name;
  final String species;
  final String house;
  final String gender;
  final String dateOfBirth;
  final bool wizard;
  final String ancestry;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final bool alive;
  final String image;

  // Constructor de la clase Character, todos los atributos son obligatorios
  Character({
    required this.name, // nombre
    required this.species, // especie
    required this.house, // casa
    required this.gender, // género
    required this.dateOfBirth, // fecha de nacimiento
    required this.wizard, // mago
    required this.ancestry, // ascendencia
    required this.hogwartsStudent, // es estudiante de Hogwarts?
    required this.hogwartsStaff, // personal de Hogwarts?
    required this.alive, // está vivo?
    required this.image, // imagen
  });

  // Crea un personaje desde un JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? '',
      species: json['species'] ?? '',
      house: json['house'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      wizard: json['wizard'] ?? false,
      ancestry: json['ancestry'] ?? '',
      hogwartsStudent: json['hogwartsStudent'] ?? false,
      hogwartsStaff: json['hogwartsStaff'] ?? false,
      alive: json['alive'] ?? true,
      image: json['image'] ?? '',
    );
  }
}
