import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  final Item? item; // Paramètre optionnel pour la mise à jour

  AddItemScreen({this.item});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      // Si un item est passé, pré-remplir les champs pour la mise à jour
      _nameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
    }
  }

  void _saveItem() async {
    final name = _nameController.text;
    final price = double.parse(_priceController.text);

    // Créer l'item sans fournir d'ID pour un nouvel item (ID sera généré par MongoDB)
    final newItem = Item(
      id: widget.item?.id ?? '', // Si c'est un nouvel item, on peut laisser l'ID vide ou null
      name: name,
      price: price,
    );

    if (widget.item == null) {
      // Si aucun item n'est passé, c'est une création
      await ApiService().addItem(newItem);
    } else {
      // Sinon, c'est une mise à jour
      await ApiService().updateItem(widget.item!.id, newItem);
    }

    Navigator.pop(context);  // Retourner à l'écran précédent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item == null ? 'Ajouter un item' : 'Modifier un item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom de l\'item'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text(widget.item == null ? 'Ajouter' : 'Mettre à jour'),
            ),
          ],
        ),
      ),
    );
  }
}
