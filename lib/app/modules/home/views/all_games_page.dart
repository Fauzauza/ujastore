import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:ujastore/app/data/models/product_model.dart';
import 'product_detail_view.dart';
import '../../../data/models/product_list.dart';

class AllGamesPage extends StatefulWidget {
  @override
  _AllGamesPageState createState() => _AllGamesPageState();
}

class _AllGamesPageState extends State<AllGamesPage> {
  List<Product> filteredGames = []; // Inisialisasi dengan daftar kosong
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredGames = games; // Mengisi filteredGames dengan semua produk saat inisialisasi
  }

  void _startListening() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() => isListening = true);
      speech.listen(onResult: (result) {
        setState(() {
          searchQuery = result.recognizedWords;
          _filterGames();
        });
      });
    }
  }

  void _stopListening() {
    setState(() => isListening = false);
    speech.stop();
  }

  void _filterGames() {
    setState(() {
      filteredGames = games
          .where((game) =>
              game.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Game'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(isListening ? Icons.mic : Icons.mic_none),
            onPressed: isListening ? _stopListening : _startListening,
          ),
        ],
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                      _filterGames();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Cari game...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGames.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.white,
                      shadowColor: Colors.black.withOpacity(0.2),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            filteredGames[index].imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          filteredGames[index].name,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Get.to(() => ProductDetailView(product: filteredGames[index]));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
