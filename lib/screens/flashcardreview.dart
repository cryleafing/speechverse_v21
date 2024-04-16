// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../sqlite/flashcard_db_helper.dart';
import 'dart:async'; // for timer integration
import '/tts_service.dart'; // for text to speech...

class FlashcardReviewPage extends StatefulWidget {
  const FlashcardReviewPage({super.key});

  @override
  _FlashcardReviewPageState createState() => _FlashcardReviewPageState();
}

class _FlashcardReviewPageState extends State<FlashcardReviewPage> {
  List<Flashcard> flashcards = [];
  int currentIndex = 0;
  List<Map<String, dynamic>> decks = [];
  int? currentDeckId;

  final TtsService _ttsService = TtsService(); // initialise tts
  bool isFront = true;
  Timer? _timer;
  int _seconds = 0;
  // start timer based on how long users spend on this page...

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      int sessionDuration = _seconds; // gapture the duration before resetting
      _seconds = 0; // Reset timer
      storeSessionTime(sessionDuration); // store the session time
    }
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _loadFlashcards();
    _loadDecks();
  }

  // store the session time recorded by timer
  void storeSessionTime(int seconds) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // make sure theres a user, firebaseauth...
      var ref = FirebaseDatabase.instance
          .ref("study_sessions/${FirebaseAuth.instance.currentUser?.uid}");
      ref
          .push()
          .set({
            'duration': seconds,
            'timestamp': ServerValue.timestamp,
          })
          .then((_) {})
          .catchError((error) {});
    }
  }

  Future<void> _loadDecks() async {
    // retrieve
    final deckList = await FlashcardDatabaseHelper.instance.getAllDecks();
    if (deckList.isNotEmpty) {
      setState(() {
        decks = deckList;
        currentDeckId = decks[0]['id'];
        _loadFlashcards();
      });
    }
  }

  Future<void> _loadFlashcards() async {
    if (currentDeckId != null) {
      final cards = await FlashcardDatabaseHelper.instance
          .getFlashcardsForDeck(currentDeckId!);
      setState(() {
        flashcards = cards;
        currentIndex = 0; // Reset to the first card when deck changes
      });
    }
  }

  // TTS will read only the front text.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up), // should speak out the text
            onPressed: () {
              String textToSpeak = isFront
                  ? flashcards[currentIndex].frontText //  speak string
                  : flashcards[currentIndex].backText;
              _ttsService.speak(textToSpeak);
            },
          ),
        ],
      ),
      body: decks.isEmpty
          ? const CircularProgressIndicator()
          : Column(
              children: [
                DropdownButton<int>(
                  value: currentDeckId,
                  onChanged: (int? newValue) {
                    setState(() {
                      currentDeckId = newValue;
                      _loadFlashcards();
                    });
                  },
                  items: decks
                      .map<DropdownMenuItem<int>>((Map<String, dynamic> deck) {
                    return DropdownMenuItem<int>(
                      value: deck['id'],
                      child: Text(deck['deck_name']),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: flashcards.isNotEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => setState(() => isFront = !isFront),
                                child: FlipCard(
                                  direction: FlipDirection.HORIZONTAL,
                                  front: Card(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          flashcards[currentIndex].frontText,
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  back: Card(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          flashcards[currentIndex].backText,
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: currentIndex > 0
                                        ? () {
                                            setState(() {
                                              currentIndex--;
                                              isFront =
                                                  true; // reset to front when changing cards
                                            });
                                          }
                                        : null,
                                    child: const Text('Previous'),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        currentIndex < flashcards.length - 1
                                            ? () {
                                                setState(() {
                                                  currentIndex++;
                                                  isFront = true;
                                                });
                                              }
                                            : null,
                                    child: const Text('Next'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const Center(child: Text('No flashcards available')),
                ),
              ],
            ),
    );
  }
}
