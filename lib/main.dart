import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SimpleVote()));

class SimpleVote extends StatefulWidget {
  @override
  _SimpleVoteState createState() => _SimpleVoteState();
}

class _SimpleVoteState extends State<SimpleVote> {
  List<String> names = [];
  List<int> votes = [];
  int totalPeople = 0, peopleVoted = 0;
  bool setupDone = false;

  final countCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  void resetApp() {
    setState(() {
      names.clear();
      votes.clear();
      countCtrl.clear();
      nameCtrl.clear();
      totalPeople = 0;
      peopleVoted = 0;
      setupDone = false;
    });
  }

  void showWinnerPopup() {
    int maxVotes = votes[0];
    int winnerIndex = 0;

    for (int i = 1; i < votes.length; i++) {
      if (votes[i] > maxVotes) {
        maxVotes = votes[i];
        winnerIndex = i;
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Winner"),
        content: Text("${names[winnerIndex]} won with $maxVotes votes"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Vote")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: !setupDone ? buildSetup() : buildVoting(),
      ),
    );
  }

  Widget buildSetup() {
    return Column(
      children: [
        TextField(
          controller: countCtrl,
          decoration: InputDecoration(labelText: "Step 1: Total Voters Count"),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: "Step 2: Add Choice Name"),
        ),
        ElevatedButton(
          child: Text("Add Choice"),
          onPressed: () {
            if (nameCtrl.text.trim().isNotEmpty) {
              setState(() {
                names.add(nameCtrl.text.trim());
                votes.add(0);
                nameCtrl.clear();
              });
            }
          },
        ),
        Text("Total choices so far: ${names.length}"),
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text("LOCK SETTINGS & START"),
          onPressed: () {
            int voters = int.tryParse(countCtrl.text) ?? 0;
            if (names.isNotEmpty && voters > 0) {
              setState(() {
                totalPeople = voters;
                setupDone = true;
              });
            }
          },
        ),
      ],
    );
  }

  Widget buildVoting() {
    bool isFinished = peopleVoted >= totalPeople;

    return Column(
      children: [
        Text(
          "Progress: $peopleVoted / $totalPeople",
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, i) => Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(names[i]),
                trailing: Text("Votes: ${votes[i]}"),
                onTap: !isFinished
                    ? () {
                        setState(() {
                          votes[i]++;
                          peopleVoted++;
                        });

                        if (peopleVoted == totalPeople) {
                          showWinnerPopup();
                        }
                      }
                    : null,
              ),
            ),
          ),
        ),
        if (isFinished) ...[
          Text(
            "VOTING FINISHED!",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          ElevatedButton(
            onPressed: resetApp,
            child: Text("RESTART NEW POLL"),
          ),
        ],
      ],
    );
  }
}