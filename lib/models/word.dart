class Word {
  final List<String> translations;

  Word({required this.translations});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      translations: List<String>.from(json['words']),
    );
  }
}