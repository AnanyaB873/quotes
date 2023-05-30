import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html/parser.dart';
import 'package:quotes/quotes2.dart';
class quotes extends StatefulWidget {
  const quotes({Key? key}) : super(key: key);

  @override
  State<quotes> createState() => _quotesState();
}

class _quotesState extends State<quotes> {
  List<String> Categories = ["love","INSPIRATIONAL","LIFE","HUMOR"];
List quotes=[];
List authors=[];
bool isDataThere=false;
@override
void initState(){
  super.initState();
  setState(() {
    getquotes();
  });
}
getquotes() async {
  String url='https://quotes.toscrape.com/';
  Uri uri=Uri.parse(url);
  http.Response response= await http.get(uri);
  dom.Document document = parser.parse(response.body);
  final quotesclass= document.getElementsByClassName("quote");
  quotes=
      quotesclass.map((element) => element.getElementsByClassName('text')[0].innerHtml).toList();
  authors=
      quotesclass.map((element) => element.getElementsByClassName('authors')[0].innerHtml).toList();
  setState(() {
    isDataThere = true;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.pink ,
        body: SingleChildScrollView(
          child: Column(
        children: [
        Container(
        child: Text('QUOTES APP',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
    ),
      GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children:
          Categories.map((Category){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>quotes2(Category),));
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                    BorderRadius.all(Radius.circular(20.0),),
                  ),
                  child: Text(Category.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),)
          ),
            );
        }).toList(),

      ),
          SizedBox(height: 40,),
          isDataThere==false?Center(child: CircularProgressIndicator(),):
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount:quotes.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Container(
                    child: Card(
                      child: Column(
                          children:[
                            Text(quotes[index]) ,
                            Text(authors[index]),
                          ]
                      ),
                    ));
              })]),
        ));
  }
}

