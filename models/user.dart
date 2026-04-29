import 'book.dart';
import 'person.dart';

class User implements Person {
List<Book> _borrowedBooks=[];
  @override
  String id;
  String name;
  User({required this.id, required this.name});

  List<Book> get borrowedBooks => _borrowedBooks;

  void set borrowedBooks(List<Book> books) {
    _borrowedBooks = books;
  }
}