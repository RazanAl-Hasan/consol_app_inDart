import 'models/book.dart';
import 'models/user.dart';
import 'dart:io';
import 'utils/simulateDelay.dart';

List<User> users = [
  User(id: 'u1', name: 'Ali'),
  User(id: 'u2', name: 'Ahmed'),
  User(id: 'u3', name: 'Mohamed'),
];

List<Book> books = [
  Book(title: 'a', author: '1', isbn: '123', availableCopies: 2),
  Book(title: 'b', author: '2', isbn: '456', availableCopies: 3),
  Book(title: 'c', author: '3', isbn: '789', availableCopies: 1),
  Book(title: 'd', author: '4', isbn: '101', availableCopies: 2),
  Book(title: 'e', author: '5', isbn: '112', availableCopies: 4),
];

void main(List<String> args) async {

  while (true) {
  await simulateDelay();
    print("=== Mini Library System ===");
    print("1.view all books");
    print("2.Register new user");
    print("3.Borrow a book");
    print("4.Return a book");
    print("5.Show some user borrowed books");
    print("\x1B[31m6.Exit\x1B[0m");

    stdout.write("\x1B[34mEnter your choice: \x1B[0m");
    String? choice = stdin.readLineSync();
    if (choice == "1") {
      print("Available Books:");
      showBook(books);
      await simulateDelay();
    } else if (choice == "2") {
      registerUser();
      await simulateDelay();
    } else if (choice == "3") {
      borrowBook();
      await simulateDelay();
    } else if (choice == "4") {
      returnBook();
      await simulateDelay();  
    } else if (choice == "5") {
      showUserBorrowedBooks();
      await simulateDelay();
    } else if (choice == "6") {
      print("\x1B[31mExiting...\x1B[0m");
      break;
    }
  }
}

void showBook(List<Book> books) {
  try{
  books.forEach((book) {
    print(
      "[${book.isbn}] ${book.title} by ${book.author} (${book.availableCopies} copies)",
    );
  });}
  catch(e){
    print("\x1B[31mAn error occurred : $e\x1B[0m");  
}}

void registerUser() {
  stdout.write("\x1B[32mEnter user ID: \x1B[0m");
  String? id = stdin.readLineSync();
  stdout.write("\x1B[32mEnter user name: \x1B[0m");
  String? name = stdin.readLineSync();
  if (id != null && name != null && id.isNotEmpty && name.isNotEmpty) {
    User newUser = User(id: id, name: name);
    try{
    users.add(newUser);}
    catch(e){
      print("\x1B[31mAn error occurred : $e\x1B[0m");
      return;
    }
    print("\x1B[32mUser `${newUser.name}` registered successfully!\x1B[0m");
  } else {
    print("\x1B[31minvalid input. User registration failed.\x1B[0m");
  }
  print('-------------------------------');
}

void borrowBook() async {
  stdout.write("\x1B[34mEnter user ID: \x1B[0m");
  String? userId = stdin.readLineSync();
  if (userId == null || userId.isEmpty) {
    print("\x1B[31minvalid user ID\x1B[0m");
    return;
  }
  User? user;
  for (var u in users) {
    if (u.id == userId) {
      user = u;
      break;
    }
  }
  if (user == null) {
    print("\x1B[31mUser not found.\x1B[0m");
    return;
  }
  stdout.write("\x1B[34mEnter book isbn to borrow: \x1B[0m");
  String? isbn = stdin.readLineSync();
  if (isbn == null || isbn.isEmpty) {
    print("\x1B[31minvalid isbn\x1B[0m");
    return;
  }
  Book? book;
  for (var b in books) {
    if (b.isbn == isbn) {
      book = b;
      break;
    }
  }
  if (book == null) {
    print("\x1B[31mBook not found\x1B[0m");
    return;
  }
try{
  if (book.availableCopies > 0) {
    book.availableCopies--;
    user.borrowedBooks.add(book);
    print("\x1B[33mProcessing...\x1B[0m");
    await simulateDelay();
    print("\x1B[32mBook `${book.title}` borrowed successfully by `${user.name}`\x1B[0m");
  } else {
    print("\x1B[31mSorry `${book.title}` is currently unavailable\x1B[0m");
  }
} catch(e){
  print("\x1B[31mAn error occurred : $e\x1B[0m");

}}

void returnBook() async {
  stdout.write("\x1B[32mEnter user ID: \x1B[0m");
  String? userId = stdin.readLineSync();
  if (userId == null || userId.isEmpty) {
    print("\x1B[31minvalid user ID\x1B[0m");
    return;
  }
  User? user;
  for (var u in users) { if (u.id == userId) {
      user = u;
      break; }}
  if (user == null) {
    print("\x1B[31mUser not found\x1B[0m");
    return;}

  stdout.write("\x1B[34mEnter book isbn to return: \x1B[0m");
  String? isbn = stdin.readLineSync();
  if (isbn == null || isbn.isEmpty) {
    print("\x1B[31minvalid isbn\x1B[0m");
    return;
  }
  Book? book;
  for (var b in books) {
    if (b.isbn == isbn) {
      book = b;
      break;
    }
  }
  if (book == null) {
    print("\x1B[31mBook not found\x1B[0m");
    return;
  }
  book.availableCopies++;
  try{
  user.borrowedBooks.remove(book);}
  catch(e){
    print("\x1B[31mAn error occurred : $e\x1B[0m");
    return;
}
  await simulateDelay();
  print("\x1B[32m`${book.title}` returned successfully \x1B[0m");
}

void showUserBorrowedBooks() {
  stdout.write("\x1B[34mEnter user ID: \x1B[0m");
  String? userId = stdin.readLineSync();
  if (userId == null || userId.isEmpty) {
    print("\x1B[31minvalid user ID\x1B[0m");
    return;
  }
  User? user;
  for (var u in users) {
    if (u.id == userId) {
      user = u;
      break;
    }
  }
  if (user == null) {
    print("\x1B[31mUser not found\x1B[0m");
    return;
  }
  if (user.borrowedBooks.isEmpty) {
    print("\x1B[33m`${user.name}` has not borrowed any books\x1B[0m");
  } else {
    try{
    print("\x1B[36m`${user.name}` has borrowed the following books:\x1B[0m");
    user.borrowedBooks.forEach((book) {
      print("\x1B[36m- ${book.title} by ${book.author}\x1B[0m");
    });
  } catch(e){
    print("\x1B[31mAn error occurred : $e\x1B[0m");
  }
}}