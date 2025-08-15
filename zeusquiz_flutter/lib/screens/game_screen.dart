import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // For Timer
import '../theme_provider.dart';
import '../quiz_data.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showResult = false;
  String? _selectedAnswer;
  bool? _isCorrect;
  final List<String> _phoneBackgrounds = [
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/phone3.png',
  ];

  String get _currentPhoneBackground =>
      _phoneBackgrounds[_currentQuestionIndex % _phoneBackgrounds.length];

  final Map<String, String> _deityImages = {
    'Aphrodite': 'assets/images/Aphrodite.png',
    'Ares': 'assets/images/Ares.png',
    'Artemis': 'assets/images/Artemis.png',
    'Apollo': 'assets/images/Apollo.png',
    'Athena': 'assets/images/Athena.png',
    'Poseidon': 'assets/images/Poseidon.png',
    'Hera': 'assets/images/Hera.png',
    'Persephone': 'assets/images/Persephone.png',
    'Zeus': 'assets/images/Zeus.png',
    'Dionysus': 'assets/images/Dionysus.png',
    'Demeter': 'assets/images/Demeter.png',
    'Hermes': 'assets/images/Hermes.png',
    'Hephaestus': 'assets/images/Hephaestus.png',
  };

  void _handleAnswerPress(String selectedOption) {
    setState(() {
      _selectedAnswer = selectedOption;
      final correct = selectedOption == quizData[_currentQuestionIndex].correctAnswer;
      _isCorrect = correct;

      if (correct) {
        _score++;
      }
    });

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _selectedAnswer = null;
        _isCorrect = null;

        if (_currentQuestionIndex < quizData.length - 1) {
          _currentQuestionIndex++;
        } else {
          _showResult = true;
        }
      });
    });
  }

  void _handleRestart() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _showResult = false;
      _selectedAnswer = null;
      _isCorrect = null;
    });
  }

  void _handleBackToMenu() {
    context.go('/');
  }

  Color _getAnswerButtonColor(String option, AppTheme theme) {
    if (_selectedAnswer == option) {
      return _isCorrect! ? theme.success : theme.error;
    }
    return theme.accent;
  }

  String _getResultTitle(double percentage) {
    if (percentage >= 90) {
      return 'Olympian Master!';
    } else if (percentage >= 80) {
      return 'Divine Knowledge!';
    } else if (percentage >= 70) {
      return 'Heroic Wisdom!';
    } else if (percentage >= 60) {
      return 'Mortal Scholar!';
    } else if (percentage >= 50) {
      return 'Aspiring Hero!';
    } else {
      return 'Mortal Beginner!';
    }
  }

  String _getResultMessage(double percentage) {
    if (percentage >= 90) {
      return 'You have the wisdom of Zeus himself!';
    } else if (percentage >= 80) {
      return 'You are truly blessed by the gods!';
    } else if (percentage >= 70) {
      return 'You have proven yourself worthy!';
    } else if (percentage >= 60) {
      return 'You have good knowledge of the myths!';
    } else if (percentage >= 50) {
      return 'You have some knowledge to build upon!';
    } else {
      return 'Time to study the ancient texts!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;

    if (_showResult) {
      final percentage = (_score / quizData.length) * 100;
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_phoneBackgrounds[0]), // You might want a fixed background for result screen or choose one dynamically
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getResultTitle(percentage),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.text,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${_score}/${quizData.length}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: theme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${percentage.round()}%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.secondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _getResultMessage(percentage),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.text,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _handleRestart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _handleBackToMenu,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.accent,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Back to Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.background,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final currentQuestion = quizData[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Greek Mythology Quiz'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_currentPhoneBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1} of ${quizData.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.text,
                    ),
                  ),
                  Text(
                    'Score: $_score',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.background.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.text,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1, // Adjusted for square buttons
                  ),
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    return Opacity(
                      opacity: 0.9, // React Native's opacity style
                      child: ElevatedButton(
                        onPressed: _selectedAnswer == null
                            ? () => _handleAnswerPress(option)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getAnswerButtonColor(option, theme),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          shadowColor: Colors.black.withOpacity(0.22),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _deityImages[option]!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              option,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_selectedAnswer != null) // Feedback container
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  _isCorrect!
                      ? 'Correct! ⚡'
                      : 'Wrong! The answer is ${currentQuestion.correctAnswer}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isCorrect! ? theme.success : theme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
