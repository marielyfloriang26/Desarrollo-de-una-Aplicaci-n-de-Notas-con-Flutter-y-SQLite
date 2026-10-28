import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'nota.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Nota> _notas = [];

  @override
  void initState() {
    super.initState();
    _cargarNotas();
  }

  Future<void> _cargarNotas() async {
    final notas = await DbHelper.instance.obtenerNotas();
    setState(() => _notas = notas);
  }

  // Formulario para crear (nota == null) o editar (nota != null)
  Future<void> _mostrarFormulario([Nota? nota]) async {
    final tituloCtrl = TextEditingController(text: nota?.titulo ?? '');
    final contenidoCtrl = TextEditingController(text: nota?.contenido ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(nota == null ? 'Nueva nota' : 'Editar nota'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: contenidoCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final titulo = tituloCtrl.text.trim();
              final contenido = contenidoCtrl.text.trim();
              if (titulo.isEmpty) return;

              if (nota == null) {
                await DbHelper.instance
                    .insertarNota(Nota(titulo: titulo, contenido: contenido));
              } else {
                await DbHelper.instance.actualizarNota(
                    Nota(id: nota.id, titulo: titulo, contenido: contenido));
              }
              if (ctx.mounted) Navigator.pop(ctx);
              _cargarNotas();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmarEliminar(Nota nota) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar nota'),
        content: const Text('¿Seguro que deseas eliminar esta nota?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await DbHelper.instance.eliminarNota(nota.id!);
      _cargarNotas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Notas'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _notas.isEmpty
          ? const Center(child: Text('No hay notas guardadas'))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _notas.length,
        itemBuilder: (context, i) {
          final nota = _notas[i];
          return Card(
            child: ListTile(
              title: Text(nota.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(nota.contenido,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    onPressed: () => _mostrarFormulario(nota),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmarEliminar(nota),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}