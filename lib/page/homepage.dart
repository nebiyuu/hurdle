// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hurdle/page/keyboard_view.dart';
import 'package:hurdle/page/wordleview.dart';
import 'package:hurdle/state/providee.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void didChangeDependencies() {
    Provider.of<Providee>(context, listen: false).init();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hurdle"),
        ),
        body: Center(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Consumer<Providee>(
                    builder: (context, value, child) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: value.boardlist.length,
                        itemBuilder: (context, index) {
                          final wordle = value.boardlist[index];
                          return WordleView(wordle: wordle);
                        })),
              ),
            ),
            Consumer<Providee>(
                builder: (context, value, child) => KeyboardView(
                      excludedLetters: value.excudedlist,
                      onPressed: (letter) {
                        value.inputword(letter);
                      },
                    )),
            Consumer<Providee>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      value.deleteletter();
                    },
                    child: Text('delete'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!value.isvalid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Not a valid word!")));
                      } else if (value.longenough) {
                        print("5");
                      }
                    },
                    child: Text('sumbit'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
