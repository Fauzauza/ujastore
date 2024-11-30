import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:ujastore/app/data/models/product_list.dart';
import 'package:ujastore/app/data/models/product_model.dart';

class AllGamesController extends GetxController {
  RxList<Product> filteredGames = <Product>[].obs;
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredGames.value = games;
    searchController.text = "";
  }

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(onResult: (result) {
        searchQuery = result.recognizedWords;
        searchController.text = result.recognizedWords;
        filterGames();
      });
    }
  }

  void stopListening() {
    speech.stop();
  }

  void filterGames() {
    filteredGames.value = games
        .where((game) =>
            game.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
