import 'package:flutter/material.dart';
import '../sqlite/flashcard_db_helper.dart';
import 'createflashcard.dart';

class FlashcardsPage extends StatelessWidget {
  final Deck deck;

  const FlashcardsPage({Key? key, required this.deck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.deckName),
      ),
      body: FutureBuilder<List<Flashcard>>(
        future: FlashcardDatabaseHelper.instance.getFlashcardsForDeck(deck.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
          if (snapshot.hasData) {
            List<Flashcard> flashcards = snapshot.data!;
            if (flashcards.isEmpty) {
              return Center(child: Text('No flashcards found for this deck.'));
            }
            return ListView.builder(
              itemCount: flashcards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(flashcards[index].frontText),
                  subtitle: Text(flashcards[index].backText),
                );
              },
            );
          } else {
            return Center(child: Text('No flashcards found for this deck.'));
          }
        },
      ),
    );
  }
}
