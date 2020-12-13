import 'package:apapde/fim.dart';
import 'package:apapde/regions.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:need_resume/need_resume.dart';
import 'dart:io';

class Comeco extends StatefulWidget {
   final List<Graph> graphs;
   final List<Region> regions;
   //final List<Roleta> roletas;
   final List<Node> nodes;
   final int rounds;
  Comeco({@required this.graphs, this.regions, this.nodes, this.rounds});

  @override
  _ComecoState createState() => _ComecoState();
}

class _ComecoState extends ResumableState<Comeco> {
  
  List<Text> solutions =[];
  List<SaveAvarage> avarages = [];
  List<List<String>> bestRounds;
  List<String> lista;
  int rodadaAtual;
  int regionAtual;
  bool isBigger1;
  bool isBigger2;
  bool acabou;
  bool continua = true;
  int pausedTime = 3600;


  @override
  void onPause() {
    setState(() {
      continua = false;
    });
    print('HomeScreen is paused!');
  }

  @override
  void onResume() {
    // Implement your code inside here
    setState(() {
      continua = true;
    });
    print('HomeScreen is resumed!');
  }

  @override
  void initState() { 
    regionAtual = 1;
    lista = [];
    bestRounds = List<List<String>>.generate(widget.regions.length, (index) => []);
    isBigger1 = false;
    isBigger2 = false;
    acabou = false;
    rodadaAtual = widget.rounds;
    solutions.add(Text("Rodada " + widget.rounds.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(), 
              _buildSolutionsCard(),
              ]),
          Padding(padding: EdgeInsets.only(left: 100),child: Column(
            children: [
              _buildGraph(),
              _buildCalculus(),
            ],),),
        ],
      ),
    );
  }

  Container _buildHeader(){
    return Container(
          width: MediaQuery.of(context).size.width / 5,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: 
                        (continua) ? Container(
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
                            child: GestureDetector(child: Text("PAUSAR"),onTap: (){
                              sleep(Duration(seconds: 5));
                              onPause();
                            },)
                          ),
                        ) :  Container(
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
                            child: GestureDetector(child: Text("CONTINUAR"),onTap: (){
                              onResume();
                            },)
                          ),
                      ),
                    ),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: 
                Center(
                  child: Text("RODADA " + rodadaAtual.toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ), 
              ),
            ],
          ),
        );
  }
  

  Padding _buildSolutionsCard(){
    return Padding(
          padding:EdgeInsets.all(50),
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: _buildSolutionsColumn(),
            ),
          ),
        );
  }


  Expanded _buildGraph(){

    //return SizedBox(height: 200, width: 239, child: GraphView(graph: widget.graphs[regionAtual-1], algorithm: FruchtermanReingoldAlgorithm(), ),);

    return Expanded(
              child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
                children: [
                  SizedBox(height: 200, child: Row(children: [GraphView(graph:widget.graphs[regionAtual-1], algorithm: FruchtermanReingoldAlgorithm(), ),],),),
                ],
              ),
            );


    /* return SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: 390,
        child: GraphView(
          graph: widget.graphs[regionAtual-1], 
          algorithm: FruchtermanReingoldAlgorithm(), 
        ),
      
    ); */
  }

  Hero _buildSolutionsColumn(){
    //_buildSolutions();
    return Hero(
      tag: "final",
    child:
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: 
           solutions,               
    ),
    );
  }

  Column _buildCalculus() {
    double resultado1;
    double resultado2;
    String firstWay;
    String secondWay;
    print(avarages.length);
    if(avarages.length < widget.regions.length){
      print("NÃO VOU PELO AVARAGE");
      resultado1 =  widget.regions[regionAtual-1].roleta_1.prob_1 *  
                    widget.regions[regionAtual-1].roleta_1.lucro_1 + 
                    widget.regions[regionAtual-1].roleta_1.prob_2*   
                    widget.regions[regionAtual-1].roleta_1.lucro_2;
      firstWay = "  " + widget.regions[regionAtual-1].name+ ": " + widget.regions[regionAtual-1].roleta_1.name + " = " +
                    (widget.regions[regionAtual-1].roleta_1.prob_1).toString() + " * " +  
                    (widget.regions[regionAtual-1].roleta_1.lucro_1).toString() + " + " +
                    (widget.regions[regionAtual-1].roleta_1.prob_2).toString() + " * " +  
                    (widget.regions[regionAtual-1].roleta_1.lucro_2).toString() + " = " + resultado1.toString();
      resultado2 = widget.regions[regionAtual-1].roleta_2.prob_1 *  
                    widget.regions[regionAtual-1].roleta_2.lucro_1 + 
                    widget.regions[regionAtual-1].roleta_2.prob_2*   
                    widget.regions[regionAtual-1].roleta_2.lucro_2;
      secondWay = "  " + widget.regions[regionAtual-1].name+ ": " + widget.regions[regionAtual-1].roleta_2.name + " = " +
                    (widget.regions[regionAtual-1].roleta_2.prob_1).toString() + " * " + 
                    (widget.regions[regionAtual-1].roleta_2.lucro_1).toString() + " + " + 
                    (widget.regions[regionAtual-1].roleta_2.prob_2).toString() + " * " +  
                    (widget.regions[regionAtual-1].roleta_2.lucro_2).toString() + " = " + resultado2.toString();
    }else{
      print("VOU PELO AVARAGE");
      print({avarages[0].lucro});
      print(avarages[1].lucro);
      print(avarages[2].lucro);
      int myLastAvarageIndex = avarages.indexWhere((element) => (element.round == (rodadaAtual+1) && (element.name == widget.regions[(regionAtual-1).abs()].name)));
      int lastAvarage1Index = avarages.indexWhere((element) => (element.round == (rodadaAtual+1) && (element.name == widget.regions[(regionAtual-1).abs()].roleta_1.goTo_2)));
      int lastAvarage2Index = avarages.indexWhere((element) => (element.round == (rodadaAtual+1) && (element.name == widget.regions[(regionAtual-1).abs()].roleta_2.goTo_2)));
      print(myLastAvarageIndex);
      print(lastAvarage1Index);
      print(lastAvarage2Index);
      double lucroAnterior1 = avarages[lastAvarage1Index].lucro;
      double lucroAnterior2 = avarages[lastAvarage2Index].lucro;
      double lucroAnteriorMine = avarages[myLastAvarageIndex].lucro;
      resultado1 =  widget.regions[regionAtual-1].roleta_1.prob_1 *  
                    (lucroAnteriorMine+widget.regions[regionAtual-1].roleta_1.lucro_1) + 
                    widget.regions[regionAtual-1].roleta_1.prob_2*   
                    (lucroAnterior1+widget.regions[regionAtual-1].roleta_1.lucro_2);
       firstWay ="  " + widget.regions[regionAtual-1].name+ ": " + widget.regions[regionAtual-1].roleta_1.name + " = " +
                     (widget.regions[regionAtual-1].roleta_1.prob_1).toString() + " * " +  
                    "(" + (lucroAnteriorMine).toString() + " + " +  widget.regions[regionAtual-1].roleta_1.lucro_1.toString() + ") +"+
                    (widget.regions[regionAtual-1].roleta_1.prob_2).toString() + " * " +  
                     "(" + (lucroAnterior1).toString() + " + " +  widget.regions[regionAtual-1].roleta_1.lucro_2.toString() + ")  = " + resultado1.toString();
      resultado2 = widget.regions[regionAtual-1].roleta_2.prob_1 *  
                    (lucroAnteriorMine + widget.regions[regionAtual-1].roleta_2.lucro_1)+
                    widget.regions[regionAtual-1].roleta_2.prob_2*   
                    (lucroAnterior2 + widget.regions[regionAtual-1].roleta_2.lucro_2);
      secondWay ="  " + widget.regions[regionAtual-1].name+ ": " + widget.regions[regionAtual-1].roleta_2.name + " = " +
                    (widget.regions[regionAtual-1].roleta_2.prob_1).toString() + " * " + 
                    "(" + (lucroAnteriorMine).toString() + " + " +  widget.regions[regionAtual-1].roleta_2.lucro_1.toString() + ") +"+
                    (widget.regions[regionAtual-1].roleta_2.prob_2).toString() + " * " +  
                    "(" + (lucroAnterior2).toString() + " + " + widget.regions[regionAtual-1].roleta_2.lucro_2.toString() + ")  = " + resultado2.toString();
    }
    setState(() {
      print("ATUALIZANDO O AVARAGES E IS BIGGER");
      if(resultado1 > resultado2){    
        widget.graphs[regionAtual-1].edges[0].paint = Paint()..color=Colors.green[900]..strokeWidth=5;
        avarages.add(SaveAvarage(lucro: resultado1, round: rodadaAtual, name: widget.regions[regionAtual-1].name));
        isBigger1 = true;
      }else{
        widget.graphs[regionAtual-1].edges[1].paint = Paint()..color=Colors.green[900]..strokeWidth=5;
        avarages.add(SaveAvarage(lucro: resultado2, round: rodadaAtual, name: widget.regions[regionAtual-1].name));
        isBigger2 = true;
      }
    }); 
    Column retorno = Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          decoration: BoxDecoration(
            color: (isBigger1) ? Colors.green[200] : Colors.indigo[100],
          ),
          child: Expanded(
            child: Align(alignment: Alignment.centerLeft, child: 
            Text(firstWay
                  , style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          decoration: BoxDecoration(
            color: (isBigger2) ? Colors.green[200] : Colors.indigo[100],
          ),
          child: Expanded(
            child: Align(alignment: Alignment.centerLeft, child: 
              Text(secondWay,
                  style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
    
    _updateValues(resultado1, resultado2);
    return retorno;
  }
  _eraseAll(){

      setState(() {
        widget.graphs[regionAtual-1].edges[0].paint = Paint()..color=Colors.red..strokeWidth=1;
        widget.graphs[regionAtual-1].edges[1].paint = Paint()..color=Colors.red..strokeWidth=1;
        isBigger1 = false;
        isBigger2 = false;
      });
    
  }

  _updateValues(double one, double two) async {
    await Future.delayed(const Duration(seconds:7), (){
    print("Hey");
     setState((){
       if(one > two){
          print("*************************");
          print(widget.regions[regionAtual-1].roleta_1.name);
          lista.add(widget.regions[regionAtual-1].roleta_1.name);
        }else{
          print("*************************");
          print(widget.regions[regionAtual-1].roleta_2.name);
          lista.add(widget.regions[regionAtual-1].roleta_2.name);
        }
          if(regionAtual+1 <= widget.regions.length){
            print("PRÓXIMA REGIÃO");
            print(regionAtual+1);
            regionAtual += 1;
          }else if(rodadaAtual > 1){
            print("PRÓXIMA RODADA");
            print(rodadaAtual-1);
            solutions.add(Text("{$lista}"));
            regionAtual = 1;
            rodadaAtual -= 1;
            solutions.add(Text("Rodada " + rodadaAtual.toString()));
            lista.clear();
          }else{
            solutions.add(Text("{$lista}"));
            print("ACABOU");
            acabou = true;
          }
        if(one > two){
          isBigger1 = true;
        }else{
          isBigger2 = true;
        }         
        if(acabou){
          sleep(Duration(seconds: 3));
           Navigator.pop(context);
           Navigator.push(context, 
              MaterialPageRoute(builder: (context) => 
                Final(solutions: solutions,),
              )
            ); 
            print("acabou");
        }
        _eraseAll();
        });
    });
  }

}

class SaveAvarage{
  String name;
  double lucro;
  int round;
  SaveAvarage({this.name, this.lucro, this.round});
}