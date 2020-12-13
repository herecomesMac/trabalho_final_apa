import 'dart:math';

import 'package:apapde/comeco.dart';
import 'package:apapde/node.dart';
import 'package:apapde/region_card.dart';
import 'package:apapde/regions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:graphview/Graph.dart';
import 'package:graphview/GraphView.dart';

/* import 'package:graphview/Layout.dart';
import 'package:graphview/edgerenderer/ArrowEdgeRenderer.dart';
import 'package:graphview/edgerenderer/EdgeRenderer.dart';
import 'package:graphview/edgerenderer/TreeEdgeRenderer.dart';
import 'package:graphview/forcedirected/FruchtermanReingoldAlgorithm.dart';
import 'package:graphview/layered/SugiyamaAlgorithm.dart';
import 'package:graphview/layered/SugiyamaConfiguration.dart';
import 'package:graphview/layered/SugiyamaEdgeData.dart';
import 'package:graphview/layered/SugiyamaEdgeRenderer.dart';
import 'package:graphview/layered/SugiyamaNodeData.dart';
import 'package:graphview/tree/BuchheimWalkerAlgorithm.dart'; */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner:false,
        home: GraphViewPage(),
      );
}


class GraphViewPage extends StatefulWidget {
  @override
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<GraphViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 7,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                        child: GestureDetector(
                          onTap: (){
                            showAddAlertDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), 
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("Adicionar"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    (regions.length >0 ) ? Container(
                      width: MediaQuery.of(context).size.width / 7,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 50),
                        child: GestureDetector(
                          onTap: (){
                            showStartAlertDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), 
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("Começar"),
                            ),
                          ),
                        ),
                      ),
                    ) : Container(
                      width: MediaQuery.of(context).size.width / 7,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 50),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), 
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("Começar"),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.width / 2.2,
                  child:
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: regions.length,
                      itemBuilder: (context, index){
                        return Padding(padding: EdgeInsets.only(top:20), child: RegionCard(region: regions[index]));
                      },
                    ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
                children: [
                  for(int i=0; i< graphs.length; i++) SizedBox(height: 200, child: Row(children: [GraphView(graph: graphs[i], algorithm: FruchtermanReingoldAlgorithm(), ),],),),
                 /*  Expanded(
                    child: SizedBox(                      
                      height: 200.0 /*- (graphs.length.toDouble() * 50)*/,
                      child: Row(
                        children: [
                          for(int i=0; i< graphs.length; i++) GraphView(graph: graphs[i], algorithm: FruchtermanReingoldAlgorithm (), ),
                        ],
                      ),
                    ),
                    ), */
                ],
              ),
            ),
          ],
        )
    );
  }


  createNode(Region region){
    Node newRegion = Node(GetNode(id: region.name));
    Node newRolet1 = Node(GetNode(id: region.roleta_1.name));
    Node newRolet1GoTo1 = Node(GetNode(id: region.roleta_1.goTo_1));
    Node newRolet1GoTo2 = Node(GetNode(id: region.roleta_1.goTo_2));
    Node newRolet2 = Node(GetNode(id:region.roleta_2.name));
    Node newRolet2GoTo1 = Node(GetNode(id: region.roleta_2.goTo_1));
    Node newRolet2GoTo2 = Node(GetNode(id: region.roleta_2.goTo_2));
    Graph newGraph = new Graph();
    setState(() {
      nodes.addAll({newRegion, newRolet1, newRolet2});
      newGraph.addEdge(newRegion, newRolet1, paint: Paint()..color = Colors.red);
      newGraph.addEdge(newRegion, newRolet2, paint: Paint()..color = Colors.red);
      newGraph.addEdge(newRolet1, newRolet1GoTo1, paint: Paint()..color = Colors.red);
      newGraph.addEdge(newRolet1, newRolet1GoTo2, paint: Paint()..color = Colors.red);
      newGraph.addEdge(newRolet2, newRolet2GoTo1, paint: Paint()..color = Colors.red);
      newGraph.addEdge(newRolet2, newRolet2GoTo2, paint: Paint()..color = Colors.red);
      graphs.add(newGraph);
    });
  }

  createData(List<String> data){
    setState(() {
      regions.add(
      Region(
        name: data[0],
        roleta_1: Roleta(
          name: data[1],
          goTo_1: data[2],
          prob_1: double.parse(data[3]) / 100,
          lucro_1: int.parse(data[4]),
          goTo_2: data[5],
          prob_2: double.parse(data[6]) /100,
          lucro_2: int.parse(data[7]),
        ),
        roleta_2: Roleta(
          name: data[8],
          goTo_1: data[9],
          prob_1: double.parse(data[10]) / 100,
          lucro_1: int.parse(data[11]),
          goTo_2: data[12],
          prob_2: double.parse(data[13]) / 100,
          lucro_2: int.parse(data[14]),
        ),
      ),
    );
    });
    createNode(regions[regions.length-1]);
    print(regions.length);
  }

  showStartAlertDialog(BuildContext context){
    int r =  Random().nextInt(regions.length)+ 1; 
    int name;
        Widget okButton = FlatButton(
        child: Text("Começar"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => 
                Comeco(
                  graphs: graphs,
                  regions: regions,
                  nodes: nodes,
                  rounds: name,
                )
              )
            );
          },
        );
        AlertDialog alerta = AlertDialog(
        title: Text("Quantas rodadas?"),
        content: 
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return 
              Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Rodadas",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.blue),
                        )
                      ),
                      onChanged: (value){
                        setState((){
                          name = int.parse(value);
                        });
                        name = int.parse(value);
                        print({name});
                        }
                    ),
                  ],
                  );
                }
          ),
        actions: [
          okButton,
        ],
      );

      // exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
  }

  showAddAlertDialog(BuildContext context){
    List<String> name;
    print(regions.length);
    Widget okButton = FlatButton(
    child: Text("Criar"),
      onPressed: () {
        createData(name);
        Navigator.of(context).pop();
       },
    );
    AlertDialog alerta = AlertDialog(

    title: Text("Adicionar Dados"),
    content: 
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Adicione os dados como mostrados abaixo ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text("Tudo na mesma linha separado por ; (ponto e vírgula) ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nome da Região"),
                Text("Nome da Primeira Roleta"),
                Text("Primeira Região Que a Primeira Roleta Vai"),
                Text("Probabilidade"),
                Text("Lucro"),
                Text("Segunda Região Que a Primeira Roleta Vai"),
                Text("Probabilidade"),
                Text("Lucro"),
                Text("Nome da Segunda Roleta"),
                Text("Primeira Região Que a Segunda Roleta Vai"),
                Text("Probabilidade"),
                Text("Lucro"),
                Text("Segunda Região Que a Segunda Roleta Vai"),
                Text("Probabilidade"),
                Text("Lucro"),
              ],
            ),
              SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: "Dados",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.blue),
                )
              ),
              onChanged: (value){
                name = value.split(";");
                print({name});
                if(name.length != 15){
                  print("Algum valor faltando");
                }
              },
            ),
          ],
        );
      },
    ),
    actions: [
      okButton,
    ],
  );

  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
  }

  Random r = Random();

  int n = 1;

  Widget getNodeText(String nodeName) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(color: Colors.blue[100], spreadRadius: 1),
          ],
        ),
        child: Text(nodeName));
  }


  

  //final Graph graph = Graph();
  List<Graph> graphs = [];

  FruchtermanReingoldAlgorithm   builder = FruchtermanReingoldAlgorithm();
  List<String> enteredData = [];
  List<Region> regions = [];
  List<Roleta> roletas = [];
  List<Node> nodes = [];
  bool newRoleta = false;
  @override
  void initState() {


    /* final Node regionI = Node(getNodeText("I"), key: Key("I"));
    final Node regionII = Node(getNodeText("II"));
    final Node regionIII = Node(getNodeText("III"));
    final Node roletA = Node(getNodeText("A"), key: Key("A"));
    final Node roletB = Node(getNodeText("B"), key: Key("B"));
    final Node roletC = Node(getNodeText("C"));
    final Node roletD = Node(getNodeText("D"));
    final Node roletE = Node(getNodeText("E"));
    final Node roletF = Node(getNodeText("F"));  */


    /*graph.addEdge(regionI, roletA, paint: Paint()..color = Colors.red);
    //graph.addEdge(regionI, roletB);
    graph.addEdge(roletA, regionI, paint: Paint()..color=Colors.blue);
    graph.addEdge(roletB, regionI, paint: Paint()..color=Colors.blue..strokeWidth=3);
    graph.addEdge(regionI, roletB, paint: Paint()..color = Colors.red..strokeWidth=1);
    
    graph.addEdge(regionII, roletC, paint: Paint()..color = Colors.red);
    graph.addEdge(regionII, roletD, paint: Paint()..color = Colors.red);
    graph.addEdge(regionIII, roletE, paint: Paint()..color = Colors.red);
    graph.addEdge(regionIII, roletF, paint: Paint()..color = Colors.red); 
    //Region I - Rolets
    
    graph.addEdge(roletA, regionII, paint: Paint()..color=Colors.blue);
    //graph.addEdge(roletB, regionI, paint: Paint()..color=Colors.blue);
    graph.addEdge(roletB, regionIII,paint: Paint()..color=Colors.blue);
    //Region II - Rolets
    graph.addEdge(roletC, regionII);
    //graph.addEdge(roletC, regionI);
    graph.addEdge(roletD, regionII);
    graph.addEdge(roletD, regionIII);
     //Region II - Rolets
    graph.addEdge(roletE, regionIII);
    //graph.addEdge(roletE, regionI);
    graph.addEdge(roletF, regionIII);
    graph.addEdge(roletF, regionII);  */

    /*graph.addEdge(regionI, regionII);
    graph.addEdge(regionI, regionI);
    graph.addEdge(regionI, regionIII);
    graph.addEdge(regionII, regionII);
    graph.addEdge(regionII, regionI);
    graph.addEdge(regionII, regionIII);
    graph.addEdge(regionIII, regionII);
    graph.addEdge(regionIII, regionI);
    graph.addEdge(regionIII, regionIII);*/


    builder
      ..width=500
      ..attractionK=100;
      
  }
}

