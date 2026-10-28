# Desarrollo de una Aplicación de Notas con Flutter y SQLite

Aplicación móvil desarrollada utilizando el framework **Flutter** y una base de datos local mediante el paquete **SQLite (`sqflite`)**, diseñada para implementar un sistema CRUD completo (Crear, Leer, Actualizar y Eliminar) para la gestión eficiente de notas personales.

---

## ¿Qué contiene la aplicación? (Características Principales)

1. **Creación y Registro de Notas:**
   - Formulario interactivo integrado con campos de texto (`TextField`) dedicados a ingresar de forma estructurada el título y el contenido detallado de cada nota, acompañado de un botón de guardado con persistencia local.

2. **Visualización en Lista Dinámica:**
   - Un componente de lista optimizado (`ListView`) que muestra en tiempo real todas las notas almacenadas en la base de datos, estructurando visualmente sus títulos y descripciones.

3. **Edición y Actualización de Registros:**
   - Funcionalidad interactiva para seleccionar una nota existente, modificar sus campos de texto y sobreescribir los cambios de manera persistente en la base de datos.

4. **Eliminación de Notas:**
   - Opciones integradas para borrar elementos de forma permanente de la base de datos local con actualización inmediata de la interfaz.

5. **Base de Datos Local (SQLite):**
   - Integración nativa del paquete `sqflite` para la creación y gestión de una base de datos relacional ligera en el dispositivo, operando completamente sin conexión a internet ni servidores externos.

---

## ¿Cómo funciona su flujo de uso?

1. **Pantalla Principal y Registro:**
   - Al abrir la aplicación (**`flutter_notes_app`**), el usuario visualiza los campos de entrada de texto para escribir una nueva nota. Al presionar el botón de guardar, la información se procesa y se inserta directamente en la tabla SQLite local.
   
2. **Carga y Lectura de Datos:**
   - La aplicación realiza una consulta asíncrona a la base de datos al iniciar y tras cada operación, cargando automáticamente los registros existentes para renderizarlos en el listado principal de la pantalla.
   
3. **Modificación y Borrado (CRUD):**
   - El usuario puede tocar cualquiera de las notas listadas para acceder a la vista de edición, actualizar su información y guardar los cambios. Asimismo, cuenta con la opción de eliminar el registro de forma definitiva con un solo toque.

---

## ¿Qué tecnologías se usaron para esto?

- **Framework:** Flutter
- **Lenguaje de Programación:** Dart
- **Gestión de Base de Datos:** SQLite (`sqflite` package) para el almacenamiento local estructurado.
- **Componentes de UI:** `TextField`, `ElevatedButton`, `ListView.builder`, `Card`, y `ListTile` para la maquetación responsiva de la interfaz.
