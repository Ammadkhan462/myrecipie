class RecipeModel {
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;

  late String appingredients;

  RecipeModel(
      {this.applabel = "LABEL",
      this.appcalories = 0.000,
      this.appimgUrl = "IMAGE",
      this.appurl = "URL",
      this.appingredients = "ing"});
  factory RecipeModel.fromMap(Map recipe) {
    List<String> ingredients = recipe["ingredientLines"].cast<String>();
    String ingredientString = ingredients.join(", ");
    return RecipeModel(
        applabel: recipe["label"],
        appcalories: recipe["calories"],
        appimgUrl: recipe["image"],
        appurl: recipe["url"],
        appingredients: ingredientString);
  }
}
