import 'package:flutter/material.dart';
import '/models/flashcard.dart';
import '/utils/db_helper.dart';
import 'AddFlashcardPage.dart';
import 'QuizPage.dart';

class InnerTilePage extends StatefulWidget {
  final Category category;
  final dbHelper = DBHelper();

  InnerTilePage({required this.category});

  @override
  _InnerTilePageState createState() => _InnerTilePageState();
}

class _InnerTilePageState extends State<InnerTilePage> {
  final dbHelper = DBHelper();
  List<Map<String, dynamic>> flashcards = [];
  List<Map<String, dynamic>> sortedFlashcards = [];
  List<Map<String, dynamic>> flashcardsForQuiz = [];
  bool isSortedAlphabetically = true;

  @override
  void initState() {
    super.initState();
    loadFlashcards();
  }

  void loadFlashcards() {
    dbHelper.queryFlashcards(
        where: 'categoryId = ?',
        whereArgs: [widget.category.id]).then((flashcards) {
      setState(() {
        this.flashcards = flashcards;
        sortedFlashcards = List.from(flashcards);
        flashcardsForQuiz = List.from(flashcards);
      });
    });
  }

  Future<void> sortQuestions() async {
    sortedFlashcards.sort((a, b) {
      return isSortedAlphabetically
          ? a['question'].compareTo(b['question'])
          : a['id'].compareTo(b['id']);
    });

    setState(() {
      isSortedAlphabetically = !isSortedAlphabetically;
      //flashcardsForQuiz.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(widget.category.title),
        actions: [
          IconButton(
            icon: Icon(
              isSortedAlphabetically ? Icons.sort_by_alpha : Icons.date_range,
            ),
            onPressed: () {
              sortQuestions();
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    flashcards: flashcardsForQuiz,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          int crossAxisCount = 2;

          if (screenWidth > 600) {
            crossAxisCount = 4;
          } else if (screenWidth > 400) {
            crossAxisCount = 3;
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
            ),
            itemCount: sortedFlashcards.length,
            itemBuilder: (context, index) {
              final flashcard = Flashcard(
                id: sortedFlashcards[index]['id'],
                categoryId: sortedFlashcards[index]['categoryId'],
                question: sortedFlashcards[index]['question'],
                answer: sortedFlashcards[index]['answer'],
              );
              return Card(
                color: Colors.teal[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddEditFlashcardPage(
                          flashcard: flashcard,
                          category: widget.category,
                          onFlashcardEdited: () {
                            loadFlashcards();
                          },
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        flashcard.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      /*IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          flashcard.delete().then((_) {
                            loadFlashcards();
                          });
                        },
                      ),*/
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditFlashcardPage(
                category: widget.category,
                onFlashcardEdited: () {
                  loadFlashcards();
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
