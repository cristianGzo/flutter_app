import 'package:flutter/material.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/tarea_model.dart';
import 'package:flutter_app/widgets/tarea_widget.dart';

class SearchTarea extends SearchDelegate<String>{
   final List<TareaModel> Lista; // Lista de tareas
   AgendaDB? agendaDB;
  // Constructor para pasar la lista de tareas
  SearchTarea(this.Lista);

  @override
  List<Widget>? buildActions(BuildContext context) {
    //limpia la pantalla
    return [
      IconButton(
       onPressed: () => this.query='',
       icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, ''), icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
     final List<TareaModel> searchResults = _performSearch(query); // Realiza la búsqueda

  return ListView.builder(
    itemCount: searchResults.length,
    itemBuilder: (BuildContext context, int index) {
      return TareaWidget(
        tareaModel: searchResults[index],
        agendaDB: agendaDB,
      );
    },
  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //return ListTile(title: Text('Suggestions'),);
    return ListView(
    children: [
      for (var suggestion in _performSearch(query))
        ListTile(
          title: Text(
            suggestion.nomTarea ?? '',
            style: TextStyle(color: Colors.black), // Establece el color del texto
          ),
          onTap: () {
            // Implementa el manejo de selección aquí
          },
        ),
    ],
  );
  }

List<TareaModel> _performSearch(String query) {
  final List<TareaModel> allTareas = Lista; // Reemplaza 'yourList' con la lista real de tareas

  // Filtra las tareas que coincidan con la búsqueda
  final List<TareaModel> searchResults = allTareas
  .where((tarea) => tarea.nomTarea?.toLowerCase().contains(query.toLowerCase()) ?? false)
  .toList();

  return searchResults;
}
}