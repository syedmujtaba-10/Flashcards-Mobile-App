I have implemented my app and database on an android device.

I have added an extra button in the entry page that clears the database. Make sure to use it when you clear all the decks.


[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=12475079&assignment_repo_type=AssignmentRepo)
# CS 442 MP3: Flashcards

## 1. Overview

Implementing a multi-page application that allows users to create, edit, and manage decks of two-sided flashcards (with nominal “questions” and “answers” on the two sides), and to run quizzes using cards drawn from a chosen deck.

Deck and flashcard information will be persisted to a local database, and the user interface is responsive to changes in screen size.

### 2.1 Feature overview

The application supports:

1. Creating, editing, and deleting decks
2. Creating, editing, sorting, and deleting flashcards (associated with a specific deck)
3. Loading a “starter set” of decks and flashcards from the JSON file.
4. Persistence of all decks and flashcards across application restarts.
5. Running a “quiz” with all the flashcards in a specific deck

#### Deck editor

The deck editor screen allows the user to change the selected deck’s title. Saving the change persists it to the database. 

#### Card list

The card list page is displayed after selecting a deck, and shows a scrollable view of all the cards in the associated deck, identified by their “question” fields. 

Tapping on a card navigates to the card editor page.

#### Card editor

The card editor page displays both the selected card’s “question” and “answer” fields, and allows both to be edited and saved.

#### Quiz

The quiz page allows the user to move through all the flashcards in the currently selected deck, displaying the questions by default, but allowing the user to “peek” at answers for knowledge review.

The flashcards are randomly shuffled upon arriving at the quiz page, and both forward and backward motion through the shuffled cards is possible (though the order of the cards will not change so long as quiz mode is not exited).

#### Responsiveness

The app is responsive to changes in screen size. 

#### External packages

I have included the following packages in the `pubspec.yaml` file:

- [`provider`](https://pub.dev/packages/provider): a state management package that you may use to manage the stateful data
- [`collection`](https://pub.dev/packages/collection): provides some helpful data structure related operations
- [`sqflite`](https://pub.dev/packages/sqflite): a database package that you should use to persist your data to a local SQLite database
- [`path_provider`](https://pub.dev/packages/path_provider): provides a platform-agnostic way to access commonly used locations on the filesystem
- [`path`](https://pub.dev/packages/path): provides common operations for manipulating paths

#### 2.3.2 Database

I used the [`sqflite`](https://pub.dev/packages/sqflite) package to persist the data to a local SQLite database. I maintained a separate table for decks and cards, linked by a foreign key. Used `path_provider` and `path` to correctly place the database file.
#### Managing asynchronous operations

The app does not cause the UI to block while performing any asynchronous operations. This includes database operations, which should be performed asynchronously. Used `FutureProvider`, `FutureBuilder`to manage asynchronous operations.
