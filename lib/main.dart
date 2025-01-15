import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> board = ["", "", "", "", "", "", "", "", ""];
  String currentPlayer = "X";
  String winner = "";

  void resetGame() {
    setState(() {
      board = ["", "", "", "", "", "", "", "", ""];
      currentPlayer = "X";
      winner = "";
    });
  }

  void playMove(int index) {
    if (board[index] == "" && winner == "") {
      setState(() {
        board[index] = currentPlayer;
        currentPlayer = currentPlayer == "X" ? "O" : "X";
        checkWinner();
      });
    }
  }

  void checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[0]] != "") {
        setState(() {
          winner = board[combo[0]];
        });
        return;
      }
    }
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => playMove(index),
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Jogo da Velha")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (winner != "") Text("Jogador $winner venceu!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            if (winner == "") Text("Vez do jogador $currentPlayer", style: TextStyle(fontSize: 30)),
            GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildCell(index);
              },
            ),
            ElevatedButton(
              onPressed: resetGame,
              child: Text("Reiniciar Jogo", style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}