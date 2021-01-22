class AssessmentQuestion {
  int _questionNumber = 0;

  List<String> _questionBank = [
    '1. Are you experiencing severe difficulty breathing?',
    '2. Are you experiencing severe chest pain??',
    '3. Are you experiencing loss of smell?',
    '4. Are you experiencing loss of taste?',
    '5. Are you experiencing fever?',
    '6. Are you experiencing chills?',
    '7. Are you experiencing fatigue?',
    '8. Are you experiencing headache?',
    '9. Are you experiencing sore throat?',
    '10.Are you experiencing nausea or vomiting?',
    '11.Are you experiencing diarrhea?'
  ];

  List<String> getAllQuestion() {
    return _questionBank;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

  bool isLast() {
    return _questionNumber == _questionBank.length - 1;
  }

  String getQuestion() {
    return _questionBank[_questionNumber];
  }
}
