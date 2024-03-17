// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool turn = true;
  List<String> displayTic = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  int oScore = 0;
  int xScore = 0;
  int isDraw = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Player O',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      oScore.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Player X',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      xScore.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _clicked(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        displayTic[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _clicked(index) {
    setState(() {
      if (turn && displayTic[index] == '') {
        displayTic[index] = 'O';
        isDraw += 1;
      } else if (!turn && displayTic[index] == '') {
        displayTic[index] = 'X';
        isDraw += 1;
      }
      turn = !turn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //1st row
    if (displayTic[0] == displayTic[1] &&
        displayTic[0] == displayTic[2] &&
        displayTic[0] != '') {
      _showDialog(displayTic[0]);
    }
    //2nd row
    if (displayTic[3] == displayTic[4] &&
        displayTic[3] == displayTic[5] &&
        displayTic[3] != '') {
      _showDialog(displayTic[3]);
    }
    //3rd row
    if (displayTic[6] == displayTic[7] &&
        displayTic[6] == displayTic[8] &&
        displayTic[6] != '') {
      _showDialog(displayTic[6]);
    }
    //1st column
    if (displayTic[0] == displayTic[3] &&
        displayTic[0] == displayTic[6] &&
        displayTic[0] != '') {
      _showDialog(displayTic[0]);
    }
    //2nd column
    if (displayTic[1] == displayTic[4] &&
        displayTic[1] == displayTic[7] &&
        displayTic[1] != '') {
      _showDialog(displayTic[1]);
    }
    //3rd column
    if (displayTic[2] == displayTic[5] &&
        displayTic[2] == displayTic[8] &&
        displayTic[2] != '') {
      _showDialog(displayTic[2]);
    }
    //diagonal 1
    if (displayTic[0] == displayTic[4] &&
        displayTic[0] == displayTic[8] &&
        displayTic[0] != '') {
      _showDialog(displayTic[0]);
    }
    //diagonal 2
    if (displayTic[2] == displayTic[4] &&
        displayTic[2] == displayTic[6] &&
        displayTic[2] != '') {
      _showDialog(displayTic[2]);
    }
    if (isDraw == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Draw',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again',
                ),
              ),
            ],
          );
        });
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'WINNER IS : $winner',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again',
                ),
              ),
            ],
          );
        });

    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
    _clear();
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayTic[i] = '';
      }
    });
    isDraw = 0;
  }
}
