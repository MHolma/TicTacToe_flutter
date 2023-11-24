import 'package:flutter/material.dart';
import 'package:tic_tac_toe3/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      
    );
  }
}

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  String Turn = "Player O turn";
  String wintext = "";
  var winner2 = TextEditingController();
  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool isrunning = true;
  Color mycolor = Color(0xFF0E1E3A);
  List<int> matchedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D58),
      body: Column(
        children: [
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Player O:",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text("$oScore",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                ],
              ),
              SizedBox(width: 80),
              Column(
                children: [
                  Text("Player X:",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  Text("$xScore",
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Turn,
                style: TextStyle(
                    color:
                        oTurn == true ? Color(0xFF1CBD9E) : Color(0xFFE25041),
                    fontSize: 40),
              ),
            ],
          ),
          Container(
            height: 500,
            child: Expanded(
              flex: 4,
              child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        tapped(index);
                      },
                      child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: matchedIndexes.contains(index)
                                ? Colors.blue
                                : Color(0xFF0E1E3A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            displayElement[index],
                            style: TextStyle(
                              fontSize: 120,
                              color: displayElement[index] == "X"
                                  ? Color(0xFFE25041)
                                  : Color(0xFF1CBD9E),
                            ),
                          ))),
                    );
                  }),
            ),
          ),
          Text(
            wintext,
            style: TextStyle(
              fontSize: 50,
              color:
                  winner2.text == "X" ? Color(0xFFE25041) : Color(0xFF1CBD9E),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 160,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.blue)))),
                  onPressed: _clearBoard,
                  child: Text(
                    "Clear board",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(width: 30),
              Container(
                height: 60,
                width: 160,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: _clearScoreBoard2,
                  child: Text(
                    "Clear scores",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == "" && isrunning == true) {
        displayElement[index] = "O";
        filledBoxes++;
        Turn = "Player X turn";
        oTurn = false;
      } else if (!oTurn && displayElement[index] == "" && isrunning == true) {
        displayElement[index] = "X";
        filledBoxes++;
        Turn = "Player O turn";
        oTurn = true;
      }

      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
      matchedIndexes.addAll([0, 1, 2]);
      isrunning = false;
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
      matchedIndexes.addAll([3, 4, 5]);
      isrunning = false;
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
      matchedIndexes.addAll([6, 7, 8]);
      isrunning = false;
    }

    // Checking Columns
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
      matchedIndexes.addAll([0, 3, 6]);
      isrunning = false;
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
      matchedIndexes.addAll([1, 4, 7]);
      isrunning = false;
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
      matchedIndexes.addAll([2, 5, 8]);
      isrunning = false;
    }

    // Checking Diagonals
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
      matchedIndexes.addAll([0, 4, 8]);
      isrunning = false;
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
      matchedIndexes.addAll([2, 4, 6]);
      isrunning = false;
    } else if (filledBoxes == 9) {
      //_showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    wintext = "'$winner' Wins";
    winner2.text = winner;

    /*showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" WINS!!!"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });*/

    if (winner == 'O' && isrunning == true) {
      oScore++;
    } else if (winner == 'X' && isrunning == true) {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
        wintext = "";
        winner2.text = "";
        matchedIndexes = [];
      }
    });
    mycolor = Color(0xFF0E1E3A);
    filledBoxes = 0;
    isrunning = true;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
    });
    filledBoxes = 0;
  }

  void _clearScoreBoard2() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure you want to reset scores"),
            actions: [
              TextButton(
                child: Text("Yes", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    xScore = 0;
                    oScore = 0;
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("No", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}*/
