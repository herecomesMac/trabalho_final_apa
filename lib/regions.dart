import 'package:flutter/foundation.dart';

class Roleta{
  String name;
  String goTo_1;
  int lucro_1;
  double prob_1;
  String goTo_2;
  int lucro_2;
  double prob_2;

  Roleta({
    @required this.name, 
    this.goTo_1, this.lucro_1, this.prob_1,
    this.goTo_2, this.lucro_2, this.prob_2,
    });
}

class Region{
  String name;
  Roleta roleta_1;
  Roleta roleta_2;

  Region({
    @required this.name,
    this.roleta_1,
    this.roleta_2,
  });
}