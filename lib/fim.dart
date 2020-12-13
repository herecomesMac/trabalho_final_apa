import 'package:flutter/material.dart';

class Final extends StatefulWidget {
  final List<Text> solutions;

  Final({this.solutions, Key key}) : super(key: key);

  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Center(
         child: 
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
           Center(child: Text("Estratégia ótima:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
         Center(child: Hero(
           tag: "final",
           child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: 
                  widget.solutions,               
            ),
         ),
           )
         ],
         ),
          ),
        ),
    );
  }
}