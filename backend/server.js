// chemin: backend/server.js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');


// Initialisation de l'app Express
const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(bodyParser.json());


const uri = '';

mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log('Connexion à MongoDB Atlas réussie');
}).catch((err) => {
    console.error('Erreur de connexion à MongoDB Atlas', err);
});

// Modèle de données
const Item = mongoose.model('Item', {
  name: String,
  description: String,
});

// CRUD: Routes
// GET - Récupérer tous les items
app.get('/items', async (req, res) => {
  try {
    const items = await Item.find();
    res.json(items);
  } catch (err) {
    res.status(400).send("Erreur lors de la récupération des items");
  }
});

// POST - Créer un nouvel item
app.post('/items', async (req, res) => {
  const newItem = new Item(req.body);
  try {
    await newItem.save();
    res.status(201).json(newItem);
  } catch (err) {
    res.status(400).send("Erreur lors de la création de l'item");
  }
});

// PUT - Mettre à jour un item
app.put('/items/:id', async (req, res) => {
  try {
    const updatedItem = await Item.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.json(updatedItem);
  } catch (err) {
    res.status(400).send("Erreur lors de la mise à jour de l'item");
  }
});

// DELETE - Supprimer un item
app.delete('/items/:id', async (req, res) => {
  try {
    await Item.findByIdAndDelete(req.params.id);
    res.status(200).send("Item supprimé");
  } catch (err) {
    res.status(400).send("Erreur lors de la suppression de l'item");
  }
});

// Démarrer le serveur
app.listen(port, () => {
  console.log(`Serveur sur http://localhost:${port}`);
});
