import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/item.dart';
import 'add_item.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<List<Item>> items;

  @override
  void initState() {
    super.initState();
    items = ApiService().fetchItems();
  }

  // Rafraîchir la liste des items après une suppression ou une modification
  void _refreshItems() {
    setState(() {
      items = ApiService().fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-item').then((_) {
                // Rafraîchir la liste des items après l'ajout d'un nouvel item
                _refreshItems();
              });
            },
            color: Colors.white, // Couleur de l'icône
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final List<Item> itemsList = snapshot.data!;

          return ListView.builder(
            itemCount: itemsList.length,
            itemBuilder: (context, index) {
              final item = itemsList[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Prix: \$${item.price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        // Naviguer vers l'écran de modification de l'item
                        final updatedItem = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddItemScreen(item: item),
                          ),
                        );
                        if (updatedItem != null) {
                          // Rafraîchir la liste après mise à jour
                          _refreshItems();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await ApiService().deleteItem(item.id);
                        _refreshItems();  // Rafraîchir la liste après suppression
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
