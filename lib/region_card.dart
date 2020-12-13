import 'package:apapde/regions.dart';
import 'package:flutter/material.dart';


class RegionCard extends StatefulWidget {
  final Region region;

  RegionCard({@required this.region});

  @override
  _RegionCardState createState() => _RegionCardState();
}

class _RegionCardState extends State<RegionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      width: MediaQuery.of(context).size.width / 4,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: _buildTable()),
    );
  }

  Widget _buildTable(){
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Center(child: Text("Região".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 0, 232, 1))),),
      Center(child: Text("Roleta".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 0, 232, 1),)),),
      Center(child: Text("Prox. Região".toUpperCase(), textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 0, 232, 1)),),),
      Center(child: Text("PROB. ".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 0, 232, 1),),),),
      Center(child: Text("Lucro".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(86, 0, 232, 1),),),),
    ]),);
    rows.add( TableRow(children: [ Center(child: Padding(padding: EdgeInsets.only(top:5), child: Text(widget.region.name))), Padding(padding: EdgeInsets.only(top:5), child: Center(child: Text(widget.region.roleta_1.name))), Padding(padding: EdgeInsets.only(top:5), child: Center(child: Text(widget.region.roleta_1.goTo_1))), Padding(padding: EdgeInsets.only(top:5), child: Center(child: Text((widget.region.roleta_1.prob_1*100).toString() + "%"))), Padding(padding: EdgeInsets.only(top:5), child: Center(child: Text(widget.region.roleta_1.lucro_1.toString()))),]),);
    rows.add( TableRow(children: [ Container(width: 0.0, height: 0.0,), Container(width: 0.0, height: 0.0,), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text(widget.region.roleta_1.goTo_2))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_1.prob_2*100).toString() + "%"))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_1.lucro_2).toString()))),]),);
    rows.add( TableRow(children: [ Container(width: 0.0, height: 0.0,), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text(widget.region.roleta_2.name))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text(widget.region.roleta_2.goTo_1))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_2.prob_1*100).toString()+"%"))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_2.lucro_1).toString()))),]),);
    rows.add( TableRow(children: [ Container(width: 0.0, height: 0.0,), Container(width: 0.0, height: 0.0,), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text(widget.region.roleta_2.goTo_2))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_2.prob_2*100).toString()+"%"))), Padding(padding: EdgeInsets.only(top:5), child: Center(child:Text((widget.region.roleta_2.lucro_2).toString()))),]),);



    return Table(
      border: TableBorder(
        verticalInside: BorderSide(
          color: Color.fromRGBO(86, 0, 232, 1),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      children: rows,
    );
  }
}
