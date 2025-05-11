import 'package:flutter/material.dart';
import '../model/character.dart';
import '../service/api_service.dart';

// Enum para representar los diferentes estados del ViewModel (mientras carga los datos de la API.)
enum ViewState {
  loading, // Cargando datos
  success, // Datos cargados
  error, // Error al cargar
  empty // Sin datos
}

// ViewModel principal que gestiona la lógica y el estado de la app
class mainViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Estado actual de la vista
  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  // Lista de todos los personajes obtenidos de la API
  List<Character> _characters = [];
  List<Character> get characters => _characters;

  // Lista de personajes filtrados por búsqueda
  List<Character> _filteredCharacters = [];
  List<Character> get filteredCharacters => _filteredCharacters;

  // Texto de búsqueda actual
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Mensaje de error
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Actualiza el estado y notifica a los listeners
  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners(); // avisa los cambios a la view (consumer los escucha)
  }

  // Carga los personajes desde la API
  Future<void> fetchCharacters() async {
    _setState(ViewState.loading);

    try {
      _characters = await _apiService.getCharacters();
      _filteredCharacters = _characters;

      _setState(_characters.isEmpty ? ViewState.empty : ViewState.success);
    } catch (e) {
      _errorMessage = 'Error al cargar los personajes: ${e.toString()}';
      _setState(ViewState.error);
      //muestra el error en la view
    }
  }

  // Filtra los personajes por nombre según el texto de búsqueda
  void searchCharacters(String query) {
    _searchQuery = query;
    _filteredCharacters = query.isEmpty
        ? _characters
        : _characters
            .where((character) =>
                character.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    _setState(_filteredCharacters.isEmpty && _characters.isNotEmpty
        ? ViewState.empty
        : ViewState.success);
  }

  // Limpia la búsqueda y muestra todos los personajes
  void clearSearch() {
    _searchQuery = '';
    _filteredCharacters = _characters;
    _setState(_characters.isEmpty ? ViewState.empty : ViewState.success);
  }
}
