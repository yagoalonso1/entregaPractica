import 'package:flutter/material.dart';
import '../model/character.dart';

// Widget que muestra la tarjeta de un personaje
class CharacterCard extends StatelessWidget {
  final Character character;

  // Constructor de la tarjeta, requiere un objeto Character
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // El widget Card da un aspecto de tarjeta con sombra
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del personaje
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(color: Colors.black54),
                  // Muestra cada atributo del personaje usando _InfoRow
                  _InfoRow(title: 'Species', value: character.species),
                  _InfoRow(title: 'Gender', value: character.gender),
                  _InfoRow(title: 'House', value: character.house),
                  _InfoRow(
                      title: 'Date Of Birth', value: character.dateOfBirth),
                  _InfoRow(
                      title: 'is a Wizard or Bridge?',
                      value: character.wizard ? 'Yes' : 'No'),
                  _InfoRow(title: 'Ancestry', value: character.ancestry),
                  _InfoRow(
                      title: 'is Hogwart\'s Student?',
                      value: character.hogwartsStudent ? 'Yes' : 'No'),
                  _InfoRow(
                      title: 'is Hogwart\'s Staff?',
                      value: character.hogwartsStaff ? 'Yes' : 'No'),
                  _InfoRow(
                      title: 'Estado',
                      value: character.alive ? 'Vivo' : 'Fallecido'),
                ],
              ),
            ),
            // Si el personaje tiene imagen, la muestra
            if (character.image.isNotEmpty) ...[
              const SizedBox(width: 16),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    character.image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, loadingProgress) {
                      // Muestra un indicador de carga mientras se descarga la imagen
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 150,
                        height: 150,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Widget privado que muestra una fila con el título y el valor de un atributo
class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  // Constructor de la fila, requiere título y valor
  const _InfoRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título en negrita
          Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? 'NaN' : value,
              style: TextStyle(
                color: value.isEmpty ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
