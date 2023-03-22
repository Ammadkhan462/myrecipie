import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:myrecipie/mainpage.dart';
import 'package:myrecipie/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List recipecatList = [
    {
      "imgurl": "https://source.unsplash.com/user/c_v_r/1900x800",
      "heading": "Apple"
    },
    {
      "imgurl": "https://source.unsplash.com/user/c_v_r/1900x800",
      "heading": "watermelon"
    },
    {
      "imgurl": "https://source.unsplash.com/user/c_v_r/1900x800",
      "heading": "Milkshake"
    }
  ];
  List<RecipeModel> recipelist = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // var city_name = ["Karachi", "Lahore", "Multan"];
  // final _random = Random();
  // var city;

  @override
  void initState() {
    super.initState();
    getrecipe("Ludoo");

    //city = city_name[_random.nextInt(city_name.length)];
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  getrecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    log(data.toString());

    recipelist.clear(); // clear the list before adding new recipe models

    data["hits"].forEach((element) {
      RecipeModel recipemodel = new RecipeModel();
      recipemodel = RecipeModel.fromMap(element["recipe"]);
      recipelist.add(recipemodel);
      log(recipelist.toString());
    });

    recipelist.forEach((Recipe) {
      print(Recipe.applabel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0XFF071938)]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
                  child: Text(
                    'What do you want t cook today?',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap:
                            true, //   when you will use listview builder in column you ave tp use this
                        itemCount: recipelist.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detailscreen(
                                          recipe: recipelist[index])));
                            },
                            child: Card(
                              elevation: 0.0,
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        recipelist[index].appimgUrl),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.7)),
                                      child: Text(
                                        recipelist[index].applabel,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    height: 25,
                                    width: 75,
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.local_fire_department,
                                              size: 15,
                                            ),
                                            Text(recipelist[index]
                                                .appcalories
                                                .toString()
                                                .substring(0, 5)),
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                Container(
                  //mycontainer
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recipecatList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              getrecipe(recipecatList[index]["heading"]);
                              print("Blank search");
                            } else {
                              getrecipe(recipecatList[index]["heading"]);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  recipecatList[index]["imgurl"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: Text(
                                      recipecatList[index]["heading"],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ))
                            ]),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          SafeArea(
            child: search(),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      //Search Wala Container

      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),

      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 15.0, // soften the shadow
          spreadRadius: 1.0, //extend the shadow
          offset: Offset(
            1.0, // Move to right 10  horizontally
            1.0, // Move to bottom 10 Vertically
          ),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              if ((searchController.text).replaceAll(" ", "") == "") {
                print("Blank search");
              } else {
                getrecipe(searchController.text);
              }
            },
            child: Container(
              child: Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
            ),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Let's Cook Something!"),
            ),
          )
        ],
      ),
    );
  }
}
