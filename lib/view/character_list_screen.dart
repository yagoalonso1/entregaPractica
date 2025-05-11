import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/character.dart';
import '../viewmodel/viewmodel.dart';
import 'character_card.dart';

// Pantalla principal que muestra la lista de personajes
class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

// Estado de la pantalla principal
class _CharacterListScreenState extends State<CharacterListScreen> {
  final TextEditingController _searchController =
      TextEditingController(); // Controlador para el campo de búsqueda

  // Se llama una vez al crear la pantalla
  @override
  void initState() {
    super.initState();
    // Cargar los personajes al iniciar la pantalla
    // Usamos Provider para acceder al ViewModel y llamar a fetchCharacters()
    // Future.microtask() asegura que se ejecute después de que el widget esté montado
    Future.microtask(() =>
        Provider.of<mainViewModel>(context, listen: false).fetchCharacters());
  }

  // Se llama al destruir la pantalla para liberar recursos
  @override
  void dispose() {
    _searchController.dispose(); // Libera el controlador de búsqueda
    super.dispose();
  }

  // Construcción de la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Scaffold es la estructura básica de una pantalla en Flutter
    return Scaffold(
      body: Column(
        children: [
          // Barra personalizada azul claro
          Container(
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Image.asset(
                  'assets/logo.png',
                  height: 48,
                ),
                const SizedBox(width: 16),
                Text(
                  'HogwAPI',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        color: Colors.white24,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Campo de búsqueda de personajes
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<mainViewModel>(
              // Consumer escucha los cambios en el ViewModel y reconstruye este widget cuando hay cambios
              builder: (context, viewModel, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black54),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar personaje por nombre...',
                      hintStyle: const TextStyle(color: Colors.black54),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.black54),
                      suffixIcon: viewModel.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  color: Colors.black54),
                              onPressed: () {
                                // Limpia el campo de búsqueda y el filtro en el ViewModel
                                _searchController.clear();
                                viewModel.clearSearch();
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    // Cada vez que el usuario escribe, se llama a searchCharacters del ViewModel
                    onChanged: viewModel
                        .searchCharacters, // Llama a la búsqueda al escribir
                  ),
                );
              },
            ),
          ),
          // Lista de personajes o mensajes según el estado
          Expanded(
            child: Consumer<mainViewModel>(
              // Este Consumer escucha el estado del ViewModel y muestra la UI adecuada
              builder: (context, viewModel, child) {
                // Mostrar diferentes widgets dependiendo del estado del ViewModel
                switch (viewModel.state) {
                  case ViewState.loading:
                    // Muestra un indicador de carga mientras se obtienen los datos
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black54),
                    );

                  case ViewState.error:
                    // Muestra un mensaje de error y botón para reintentar
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 60, color: Colors.red),
                          const SizedBox(height: 16),
                          // Muestra el mensaje de error recibido desde el ViewModel
                          Text(
                            'Error: ${viewModel.errorMessage}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            // Al pulsar, vuelve a intentar cargar los personajes llamando a fetchCharacters()
                            onPressed: viewModel.fetchCharacters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue[100],
                              foregroundColor: Colors.black87,
                            ),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    );

                  case ViewState.empty:
                    // Muestra un mensaje si no hay resultados de búsqueda o la lista está vacía
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off,
                              size: 60, color: Colors.grey),
                          const SizedBox(height: 16),
                          // Mensaje dinámico según si hay búsqueda activa o no
                          Text(
                            viewModel.searchQuery.isNotEmpty
                                ? 'No se encontraron resultados para "${viewModel.searchQuery}"'
                                : 'No se encontraron personajes',
                            textAlign: TextAlign.center,
                          ),
                          if (viewModel.searchQuery.isNotEmpty)
                            TextButton(
                              // Limpia la búsqueda y muestra todos los personajes
                              onPressed: () {
                                _searchController.clear();
                                viewModel.clearSearch();
                              },
                              child: const Text('Limpiar búsqueda'),
                            ),
                        ],
                      ),
                    );

                  case ViewState.success:
                    // Muestra la lista de personajes usando ListView.builder
                    // Cada elemento es un CharacterCard (importado de character_card.dart)
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: viewModel.filteredCharacters.length,
                      itemBuilder: (context, index) => CharacterCard(
                        character: viewModel.filteredCharacters[
                            index], // Pasa el personaje a la tarjeta
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
