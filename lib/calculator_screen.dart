import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget{
  const Calculator({super.key});
  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>{

  String userInput = "";
  String result = "0";

  List<String> buttonList=["AC",'(',')','/','7','8','9','*','4','5','6','+','1','2','3','-','C','0','.','='];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(userInput,style: const TextStyle(fontSize: 32, color: Colors.black),),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 25),
                  alignment: Alignment.centerRight,
                  child: Text(result,style:const TextStyle(
                      fontSize: 48, color: Colors.black,
                  fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          const Divider(color: Colors.black26,
          thickness: 1.2,
          endIndent: 25,
          indent: 25,),
          Expanded(child: Container(
            padding: const EdgeInsets.only(top: 10,bottom:20, right: 20,left: 20),
            child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
                itemBuilder: (BuildContext context,int index) {
                  return customButton(buttonList[index]);
                }
            ),
          ))
        ],
      ),
    );
  }

  Widget customButton(String text){
    return InkWell(
      splashColor: Colors.white60,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          // color: Colors.blue.shade100,
          color: getBgColor(text),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 4,
              offset: const Offset(-3,-3)
            )
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: getColor(text),
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text){
    if(text == "(" ||text == ")" ||text == "/" ||text == "*" ||text == "+" ||text == "-" ||text == "C"){
      return Colors.orangeAccent.shade700;
    }
    return Colors.black;
  }

  getBgColor(String text){
    if(text == "AC"){
      return Colors.orangeAccent.shade700;
    }
    if(text == "="){
      return Colors.greenAccent.shade700;
    }
    return Colors.blue.shade100;
  }

  handleButtons(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput=userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }

    if(text == "="){
      result = calculate();
      userInput = result;

      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Error";
    }
  }
}