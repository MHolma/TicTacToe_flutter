import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe3/home_screen.dart';
import 'package:vibration/vibration.dart';

class GameScreen extends StatefulWidget {
  @override
  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String _currenPlayer;

  bool oTurn = true;
  String Turn = "";
  String wintext = "";
  var winner2 = "";
  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  var drawcounter = 0;
  int filledBoxes = 0;
  bool isrunning = true;
  Color mycolor = Color(0xFF0E1E3A);
  List<int> matchedIndexes = [];

  var winner = "";

  @override
  void initState() {
    super.initState();
    _currenPlayer = "X";

    Turn = widget.player1 + "'s turn" + "(" + "O" + ")";

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    var ScreenHeight = MediaQuery.of(context).size.height;
    var blockSizeHorizontal = (ScreenWidth / 100);
    var blockSizeVertical = (ScreenHeight / 100);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Color(0xFF323D58),
        body: Column(
          children: [
            SizedBox(height: blockSizeVertical * 5),
            Text("Tic-Tac-Toe",
                style: TextStyle(
                    fontSize: blockSizeVertical * 5, color: Color(0xFF0E1E3A))),
            SizedBox(height: blockSizeVertical * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: blockSizeHorizontal*35,
                  child: Column(
                    children: [
                      Text(
                          _currenPlayer == "X"
                              ? widget.player1 + " (O)"
                              : widget.player2 + " (X)",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: widget.player1.length >10 ? blockSizeVertical*2.2 : blockSizeVertical*2.7,
                              color: _currenPlayer == "O"
                                  ? Color(0xFFE25041)
                                  : Color(0xFF1CBD9E),
                              fontWeight: FontWeight.w200)),
                      Text("$oScore",
                          style: TextStyle(
                              fontSize: blockSizeVertical * 4.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
                SizedBox(width:blockSizeHorizontal*5),
                Column(
                  children: [
                    Text(
                        "Draw",
                        style: TextStyle(
                            fontSize: blockSizeVertical * 2.7,
                            color: Colors.amber,
                            fontWeight: FontWeight.w200)),
                    Text("$drawcounter",
                        style: TextStyle(
                            fontSize: blockSizeVertical * 4.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                SizedBox(width: blockSizeHorizontal * 5),
                Container(width: blockSizeHorizontal*35,
                  child: Column(
                    children: [
                      Text(
                          _currenPlayer == "O"
                              ? widget.player1 + " (O)"
                              : widget.player2 + " (X)",
                          style: TextStyle(
                              fontSize: widget.player2.length >10 ? blockSizeVertical*2.2 : blockSizeVertical*2.7,
                              color: _currenPlayer == "X"
                                  ? Color(0xFFE25041)
                                  : Color(0xFF1CBD9E),
                              fontWeight: FontWeight.w200),
                              textAlign: TextAlign.left,),
                      Text("$xScore",
                          style: TextStyle(
                              fontSize: blockSizeVertical * 4.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: blockSizeVertical * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Turn,
                  style: TextStyle(
                      color:
                          oTurn == true ? Color(0xFF1CBD9E) : Color(0xFFE25041),
                      fontSize: blockSizeVertical * 2.7,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Container(
              height: blockSizeVertical * 47,
              width: blockSizeHorizontal * 90,
              child: Container(
                //flex: 4,
                child: GridView.builder(
                    itemCount: 9,
                    //shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
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
                                child: Container(
                              transform: Matrix4.translationValues(
                                  0.0, blockSizeVertical * -0.6, 0.0),
                              child: Text(
                                displayElement[index],
                                style: TextStyle(
                                  fontSize: blockSizeVertical * 13,
                                  color: displayElement[index] == "X"
                                      ? Color(0xFFE25041)
                                      : Color(0xFF1CBD9E),
                                ),
                              ),
                            ))),
                      );
                    }),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10, 0.0),
              child: Text(
                wintext,
                style: TextStyle(
                    fontSize: wintext.length > 15 ? blockSizeVertical * 2.7: blockSizeVertical*5,
                    color:
                      winner2 == "X" ? Color(0xFFE25041) : winner2 == "O" ?Color(0xFF1CBD9E): Colors.amber,
                    fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(height: blockSizeVertical * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: blockSizeVertical * 7,
                  width: blockSizeHorizontal * 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.blue)))),
                    onPressed: _clearBoard,
                    child: Text(
                      "Clear board",
                      style: TextStyle(
                          fontSize: blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                SizedBox(width: blockSizeHorizontal * 6),
                Container(
                  height: blockSizeVertical * 7,
                  width: blockSizeHorizontal * 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.amber)))),
                    onPressed: _clearScoreBoard,
                    child: Text(
                      "Clear scores",
                      style: TextStyle(
                          fontSize: blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: blockSizeVertical * 3),
            Container(
              height: blockSizeVertical * 7,
              width: blockSizeHorizontal * 40,
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
                onPressed: restart2,
                child: Text(
                  "Restart",
                  style: TextStyle(
                      fontSize: blockSizeVertical * 2.5,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == "" && isrunning == true) {
        HapticFeedback.heavyImpact();
        displayElement[index] = "O";
        filledBoxes++;
        Turn = widget.player2 + "'s turn" + " (" + "X" + ")";

        oTurn = false;
        //_currenPlayer = _currenPlayer == "X" ? "O" : "X";
      } else if (!oTurn && displayElement[index] == "" && isrunning == true) {
        HapticFeedback.heavyImpact();
        displayElement[index] = "X";
        filledBoxes++;
        Turn = widget.player1 + "'s turn" + " (" + "O" + ")";
        oTurn = true;
        //_currenPlayer = _currenPlayer == "X" ? "O" : "X";
      }

      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[0]);
      matchedIndexes.addAll([0, 1, 2]);
      isrunning = false;
      setState(() {
        if (displayElement[0] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[3]);
      matchedIndexes.addAll([3, 4, 5]);
      isrunning = false;
      setState(() {
        if (displayElement[3] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[6]);
      matchedIndexes.addAll([6, 7, 8]);
      isrunning = false;
      setState(() {
        if (displayElement[6] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }

    // Checking Columns
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[0]);
      matchedIndexes.addAll([0, 3, 6]);
      isrunning = false;
      setState(() {
        if (displayElement[0] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[1]);
      matchedIndexes.addAll([1, 4, 7]);
      isrunning = false;
      setState(() {
        if (displayElement[1] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[2]);
      matchedIndexes.addAll([2, 5, 8]);
      isrunning = false;
      setState(() {
        if (displayElement[2] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }

    // Checking Diagonals
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[0]);
      matchedIndexes.addAll([0, 4, 8]);
      isrunning = false;
      setState(() {
        if (displayElement[0] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '' &&
        isrunning == true) {
      Vibration.vibrate(duration: 500);
      winnerscore(displayElement[2]);
      matchedIndexes.addAll([2, 4, 6]);
      isrunning = false;

      setState(() {
        if (displayElement[2] == "O") {
          wintext = widget.player1 + " (" + "O" + ") " + "Wins";
        } else {
          wintext = widget.player2 + " (" + "X" + ") " + "Wins";
        }
      });
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void winnerscore(String winner) {
    setState(() {
      winner2 = winner;
    });

    if (winner == 'O' && isrunning == true) {
      oScore++;
    } else if (winner == 'X' && isrunning == true) {
      xScore++;
    }
  }

  void _showDrawDialog() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        if (winner2 != "") {
        } else {
          Vibration.vibrate(duration: 200);
          wintext = "Draw";
          drawcounter ++;
        }
      });
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
        wintext = "";
        winner2 = "";
        matchedIndexes = [];
      }
    });
    mycolor = Color(0xFF0E1E3A);
    filledBoxes = 0;
    isrunning = true;
  }

  void _clearScoreBoard() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Are you sure you want to reset scores"),
            actions: [
              TextButton(
                child: Text("Yes", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  setState(() {
                    xScore = 0;
                    oScore = 0;
                    drawcounter=0;
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

  void restart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    widget.player1 = "";
    widget.player2 = "";
  }

  void restart2() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text("Are you sure you want to restart"),
            actions: [
              TextButton(
                child: Text("Yes", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  widget.player1 = "";
                  widget.player2 = "";
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

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
