import 'model.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatelessWidget {
  final RecipeModel recipe;
  Detailscreen({required this.recipe});
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('this'),
        ),
        body: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0XFF071938)]),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          recipe.appimgUrl,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        color: Colors.grey,
                        child: Text(
                          recipe.applabel,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      height: 25,
                      width: 75,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          recipe.appcalories.toString().substring(0, 5),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ]),
                  Card(
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                    child: Column(
                      children: recipe.appingredients
                          .split(',')
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key + 1;
                        String ingredient = entry.value.trim();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                '$index. ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ingredient,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
