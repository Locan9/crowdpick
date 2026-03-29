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
      peopleVoted = 0;
      setupDone = false;
    });
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
        // This is only asked once at the start
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
        // This button locks everything in and switches to the voting screen
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
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
        Text("Progress: $peopleVoted / $totalPeople", style: TextStyle(fontSize: 20)),
        Expanded(
          child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, i) => Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(names[i]),
                trailing: Text("Votes: ${votes[i]}"),
                onTap: !isFinished ? () => setState(() {
                  votes[i]++;
                  peopleVoted++;
                }) : null,
              ),
            ),
          ),
        ),
        if (isFinished) ...[
          Text("VOTING FINISHED!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24)),
          ElevatedButton(onPressed: resetApp, child: Text("RESTART NEW POLL")),
        ],
      ],
    );
  }
}