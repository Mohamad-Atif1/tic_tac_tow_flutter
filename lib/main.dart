import 'package:flutter/material.dart';
import 'Constatnts/Thems/appThemLight.dart';
import 'Constatnts/Strings/app_strings.dart';
import 'Constatnts/Numaric/numaric.dart';

// array with 9 size and empty string
void main() {
  runApp(MaterialApp(
    home: const Home(),
    theme: themeData,
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool oTurn = true;
  bool scoreIsUpdated = false;
  int oScore = 0;
  int xScore = 0;
  String txtbtn = '';
  List<String> board = List.filled(9, '');
  String winner = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName, style: Theme.of(context).textTheme.titleLarge),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          height: heightSpace + 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "$playerX: $xScore",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          width: widthSpace,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$playerO: $oScore",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: heightSpace,
                    ),
                    playetTurnTxt(context),
                  ],
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: setUpBoard(),
                )),
            Expanded(
                flex: 1,
                child: Visibility(
                    visible: gameOver(),
                    child: Container(
                      width: buttonWidth,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              board = List.filled(9, '');
                              scoreIsUpdated = false;
                            });
                          },
                          child: const Text(restart)),
                    )))
          ],
        ),
      ),
    );
  }

  GridView setUpBoard() {
    return GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numOfElementsOnRow,
          crossAxisSpacing: borderWidth,
          mainAxisSpacing: borderWidth,
        ),
        itemBuilder: ((context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  if (!gameOver()) {
                    if (board[index] == '') {
                      board[index] = oTurn ? o : x;
                      oTurn = !oTurn;
                      // after he plays i need to check if still the game is not over
                      // because if it is over , i need to update the score
                      gameOver();
                    }
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Center(
                    child: Text(board[index],
                        style: Theme.of(context).textTheme.displayLarge)),
              ),
            )));
  }

  Center playetTurnTxt(BuildContext context) {
    return Center(
        child: Text(
      gameOver() ? winner : (oTurn ? oPlay : xPlay),
      style: Theme.of(context).textTheme.titleMedium,
    ));
  }

  bool gameOver() {
    for (int i = 0, j = 0; i < board.length; i += 3, j++) {
      /*
        [ 0 1 2
          3 4 5
          6 7 8 ]
      */
      // win by row combination
      if (board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2] &&
          board[i] != '') {
        winner = '${board[i]} wins! ';
        updateScore(board[i]);
        scoreIsUpdated = true;
        return true;
      }
      // win by col combination
      if (board[j] == board[j + 3] &&
          board[j + 3] == board[j + 6] &&
          board[j] != '') {
        winner = '${board[j]} wins! ';
        updateScore(board[j]);
        scoreIsUpdated = true;
        return true;
      }
    }
    // win bt diagonal combination
    if (board[0] == board[4] && board[4] == board[8] && board[0] != '') {
      winner = '${board[0]} wins! ';
      updateScore(board[0]);
      scoreIsUpdated = true;
      return true;
    }
    if (board[2] == board[4] && board[4] == board[6] && board[2] != '') {
      winner = '${board[2]} wins! ';
      updateScore(board[2]);
      scoreIsUpdated = true;
      return true;
    }

    // Draw
    if (!board.contains('')) {
      winner = draw;
      return true;
    }

    return false;
  }

  void updateScore(String player) {
    if (!scoreIsUpdated) {
      setState(() {
        if (player == x) {
          xScore++;
        } else {
          oScore++;
        }
      });
    }
  }
}
