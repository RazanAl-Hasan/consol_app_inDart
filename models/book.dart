class Book {
  String _title="";
  String _author="";
  String _isbn="";
  int _availableCopies=0;

  Book({
    required title,
    required author,
    required isbn,
    required availableCopies,
  })
  {
    this._title=title;
    this._author=author;
    this._isbn=isbn;
    this._availableCopies=availableCopies;
  }

  String get title => _title;
  String get author => _author;
  String get isbn => _isbn;
  int get availableCopies => _availableCopies;

  void set title(String value) {
    _title = value;
  }
  void set author(String value) {
    _author = value;
  }
  void set isbn(String value) {
    _isbn = value;
  }
  void set availableCopies(int value) {
    _availableCopies = value;
  }

@override
  String toString() {
    return "Books(with title, author, availableCopies)";}
}


