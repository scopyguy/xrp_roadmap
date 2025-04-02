import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FoodType {
  apple,
  banana,
  coin,
}

class Food {
  final Offset position;
  final FoodType type;

  Food(this.position, this.type);
}

class SnakeGame extends StatefulWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  late List<Offset> snake;
  late Food currentFood;
  late Direction direction;
  late int score;
  late int level;
  late bool isGameOver;
  late bool isPaused;

  final gridSize = 20;
  final double cellSize = 20.0;
  late Timer gameLoop;
  Duration gameSpeed = Duration(milliseconds: 200);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _startGame();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      snake = [Offset((cellSize ~/ 2).toDouble(), (cellSize ~/ 2).toDouble())];
      currentFood = _generateFood();
      direction = Direction.right;
      score = 0;
      level = 1;
      isGameOver = false;
      isPaused = false;
      gameSpeed = Duration(milliseconds: 200);
    });

    _startGameLoop();
  }

  void _startGameLoop() {
    gameLoop = Timer.periodic(gameSpeed, (timer) {
      if (!isPaused && !isGameOver) {
        _moveSnake();
        if (_checkCollision()) {
          setState(() {
            isGameOver = true;
          });
          gameLoop.cancel();
          _saveScore();
          showGameOverDialog();
        }
        if (_checkFoodConsumed()) {
          setState(() {
            snake.add(snake.last); // Grow the snake
            score += _getFoodScore(currentFood.type);
            if (score % 50 == 0) {
              level++;
              gameSpeed = Duration(milliseconds: gameSpeed.inMilliseconds - 10);
              gameLoop.cancel();
              _startGameLoop();
            }
            currentFood = _generateFood();
          });
        }
      }
    });
  }

  Food _generateFood() {
    final random = Random();
    final foodTypes = FoodType.values;
    final type = foodTypes[random.nextInt(foodTypes.length)];
    return Food(
      Offset(
        random.nextInt(gridSize).toDouble(),
        random.nextInt(gridSize).toDouble(),
      ),
      type,
    );
  }

  void _moveSnake() {
    final newHead = Offset(
      snake.first.dx + direction.dx,
      snake.first.dy + direction.dy,
    );
    setState(() {
      snake.insert(0, newHead);
      snake.removeLast();
    });
  }

  bool _checkCollision() {
    final head = snake.first;

    // Check wall collision
    if (head.dx < 0 ||
        head.dx >= gridSize ||
        head.dy < 0 ||
        head.dy >= gridSize) {
      return true;
    }

    // Check self collision
    for (int i = 1; i < snake.length; i++) {
      if (head == snake[i]) {
        return true;
      }
    }
    return false;
  }

  bool _checkFoodConsumed() {
    return snake.first == currentFood.position;
  }

  void _handleInput(Direction newDirection) {
    if (direction.dx == -newDirection.dx && direction.dy == -newDirection.dy) {
      return; // Prevent the snake from reversing direction
    }
    setState(() {
      direction = newDirection;
    });
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _restartGame() {
    gameLoop.cancel();
    _startGame();
  }

  void _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboard = prefs.getStringList('leaderboard') ?? [];
    leaderboard.add('Player: $score'); // Replace 'Player' with a dynamic name
    prefs.setStringList('leaderboard', leaderboard);
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  int _getFoodScore(FoodType type) {
    switch (type) {
      case FoodType.apple:
        return 10;
      case FoodType.banana:
        return 20;
      case FoodType.coin:
        return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 105, 34),
      appBar: AppBar(
        title: Text('Snake Game - Level $level'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RawKeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKey: (event) {
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                    _handleInput(Direction.up);
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                    _handleInput(Direction.down);
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    _handleInput(Direction.left);
                  } else if (event.logicalKey ==
                      LogicalKeyboardKey.arrowRight) {
                    _handleInput(Direction.right);
                  }
                }
              },
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    _handleInput(Direction.down);
                  } else if (details.delta.dy < 0) {
                    _handleInput(Direction.up);
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    _handleInput(Direction.right);
                  } else if (details.delta.dx < 0) {
                    _handleInput(Direction.left);
                  }
                },
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50, // Cream color for the grid
                        border: Border.all(color: Colors.black),
                      ),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridSize,
                        ),
                        itemCount: gridSize * gridSize,
                        itemBuilder: (context, index) {
                          final x = index % gridSize;
                          final y = index ~/ gridSize;
                          final position = Offset(x.toDouble(), y.toDouble());

                          if (snake.contains(position)) {
                            return Container(
                              color: Colors.green,
                            );
                          }

                          if (position == currentFood.position) {
                            switch (currentFood.type) {
                              case FoodType.apple:
                                return Container(color: Colors.red);
                              case FoodType.banana:
                                return Container(color: Colors.yellow);
                              case FoodType.coin:
                                return Container(color: Colors.amber);
                            }
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Score: $score'),
                IconButton(
                  icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                  onPressed: _togglePause,
                ),
              ],
            ),
          ),
          if (isGameOver)
            Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Game Over!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _restartGame,
                    child: Text('Restart'),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _handleInput(Direction.up),
              child: Icon(Icons.arrow_upward),
            ),
            ElevatedButton(
              onPressed: () => _handleInput(Direction.down),
              child: Icon(Icons.arrow_downward),
            ),
            ElevatedButton(
              onPressed: () => _handleInput(Direction.left),
              child: Icon(Icons.arrow_back),
            ),
            ElevatedButton(
              onPressed: () => _handleInput(Direction.right),
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}

class Direction {
  final double dx;
  final double dy;

  const Direction(this.dx, this.dy);

  static final up = Direction(0, -1);
  static final down = Direction(0, 1);
  static final left = Direction(-1, 0);
  static final right = Direction(1, 0);
}
