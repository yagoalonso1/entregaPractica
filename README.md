# HogwAPI

Aplicación Flutter que muestra una lista de personajes de Harry Potter consumiendo una API pública. Permite buscar personajes en tiempo real, ver detalles y maneja estados de carga y error de forma visual.

## 📱 Características principales

- **Consumo de API pública**: Obtiene datos de personajes de Harry Potter desde [hp-api.onrender.com](https://hp-api.onrender.com/).
- **Lista interactiva**: Muestra los personajes en tarjetas con información relevante y foto.
- **Búsqueda en tiempo real**: Filtra la lista de personajes conforme escribes en el campo de búsqueda.
- **Indicador de carga**: Muestra un `CircularProgressIndicator` mientras se obtienen los datos.
- **Manejo de errores**: Muestra mensajes claros si hay problemas de conexión o la API no responde.
- **Diseño moderno y responsive**: Interfaz atractiva y adaptable a diferentes dispositivos.

## 🚀 Instalación y ejecución

1. **Clona el repositorio:**

   ```sh
   git clone <URL_DEL_REPO>
   cd hogwapi
   ```

2. **Instala las dependencias:**

   ```sh
   flutter pub get
   ```

3. **Genera los iconos de la app (opcional, si cambias el logo):**

   ```sh
   flutter pub run flutter_launcher_icons:main
   ```

4. **Lanza el emulador (ejemplo con Pixel_7):**
   ```sh
   flutter emulators --launch Pixel_7
   flutter devices
   flutter run -d <id_del_pixel_7>
   ```

## 🛠️ Dependencias principales

- [provider](https://pub.dev/packages/provider) - Gestión de estado
- [http](https://pub.dev/packages/http) - Peticiones HTTP
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - Generación de iconos

## 📂 Estructura del proyecto

```
lib/
  main.dart                # Punto de entrada de la app
  model/character.dart     # Modelo de datos de personaje
  service/api_service.dart # Lógica de consumo de la API
  view/                    # Vistas principales (pantallas y widgets)
    character_list_screen.dart
    character_card.dart
  viewmodel/viewmodel.dart # Lógica de negocio y gestión de estado
assets/
  logo.png                # Logo de la app
  images/                 # (opcional) Otras imágenes
```

## ⚙️ Configuración importante

- **Nombre de la app:**
  - Definido en `android/app/src/main/AndroidManifest.xml` con `android:label="HogwAPI"`.
- **Logo de la app:**
  - Definido en `pubspec.yaml` y generado con `flutter_launcher_icons` a partir de `assets/logo.png`.
- **Assets:**
  - Declarados en `pubspec.yaml` bajo el bloque `assets:`.

## 👨‍💻 Autores

- **Yago Alonso**
- **Alex Vilanova**

---

¡Esperamos que disfrutes la app! Si tienes sugerencias o encuentras algún problema, no dudes en abrir un issue o contribuir.
