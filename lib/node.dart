import 'package:flutter/material.dart';

class GetNode extends StatefulWidget {
  final String id;
  GetNode({@required this.id});

  @override
  _GetNodeState createState() => _GetNodeState();
}

class _GetNodeState extends State<GetNode> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(color: Colors.blue[100], spreadRadius: 1),
          ],
        ),
        child: Text(widget.id));
  }
}