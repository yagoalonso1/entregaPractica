import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/viewmodel.dart';
import 'view/character_list_screen.dart';

// Función principal que inicia la aplicación
void main() {
  runApp(const MyApp());
}

// Widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider: permite que el ViewModel esté disponible en toda la app
    return ChangeNotifierProvider(
      create: (_) => mainViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HogwAPI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
          cardTheme: CardTheme(
            color: Colors.lightBlue[100],
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        home: const CharacterListScreen(),
      ),
    );
  }
}
