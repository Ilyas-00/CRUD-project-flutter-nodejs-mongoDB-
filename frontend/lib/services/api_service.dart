// chemin : frontend/lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5000/items';  // Assure-toi que ton API fonctionne sur ce port

  // Récupérer tous les items
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors du chargement des items');
    }
  }

  // Ajouter un item
  Future<void> addItem(Item item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erreur lors de l\'ajout de l\'item');
    }
  }

  // Mettre à jour un item
  Future<void> updateItem(String id, Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de l\'item');
    }
  }

  // Supprimer un item
  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression de l\'item');
    }
  }
}
