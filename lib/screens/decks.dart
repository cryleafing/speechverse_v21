import 'package:flutter/material.dart';
import 'package:speechverse_v2/screens/createflashcard.dart';
import 'package:speechverse_v2/sqlite/flashcard_db_helper.dart';

import 'flashcard_detail.dart';

class DecksPage extends StatefulWidget {
  @override
  _DecksPageState createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  //kKey to identify the FutureBuilder and force rebuilds
  Key _futureBuilderKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Decks'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        key: _futureBuilderKey, // Use the key here
        future: FlashcardDatabaseHelper.instance.getAllDecks(),
        builder: (context, snapshot) {
          // check for loading state, helps inform the user
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // check for error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          // check for and handle data state
          if (snapshot.hasData) {
            // Convert List<Map<String, dynamic>> to List<Deck>
            List<Deck> decks =
                snapshot.data!.map((deckMap) => Deck.fromMap(deckMap)).toList();
            if (decks.isEmpty) {
              // Handle the case where the decks list is empty
              return Center(
                  child: Text('No decks found. Start by creating a new one!'));
            }

            // Display the list of decks
            return ListView.builder(
              itemCount: decks.length,
              itemBuilder: (context, index) {
                Deck deck = decks[index];
                return ListTile(
                  title: Text(deck.deckName),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => FlashcardsPage(deck: deck)));
                    // specific flashcards for a certain deck...
                  },
                );
              },
            );
          } else {
            // Handle the case where there's no data (although this should be covered by the isEmpty check above)
            return Center(child: Text('No decks found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNewDeck(context),
      ),
    );
  }
}

void _addNewDeck(BuildContext context) async {
  final TextEditingController _deckTitleController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('New Deck'),
        content: TextField(
          controller: _deckTitleController,
          decoration: InputDecoration(
            labelText: 'Deck Title',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () async {
              String deckTitle = _deckTitleController.text;
              if (deckTitle.isNotEmpty) {
                // Call method to save the new deck to the database
                await FlashcardDatabaseHelper.instance.addDeck(deckTitle);

                // Update the UI or refresh the deck list
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
