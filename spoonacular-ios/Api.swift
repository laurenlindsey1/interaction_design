import Foundation

protocol Api {
    func api(host: String)
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?)
    func searchIngredients(with params: SearchIngredientsParams,
                           then: (([ResultsIngredients]) -> Void)?,
                           fail: ((Error) -> Void)?)
    
    func searchVideos(with params: SearchVideosParams,
                      then: ((SearchVideos) -> Void)?,
                      fail: ((Error) -> Void)?)
}

class ApiService: Api {
    func api(host: String) {
    }
    
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(SearchRecipes(results: [
                ResultsRecipes(
                    title: "Alfredo Potatoes", readyInMinutes: 45,servings: 4, image: "alfredo-potatoes-2-116099.png"
                ),
                ResultsRecipes(
                    title: "Perfect Scalloped Potatoes", readyInMinutes: 90,servings: 2, image: "perfect-scalloped-potatoes-1078087.jpg"
                ),
                
                ResultsRecipes(
                    title: "Homemade Tacos Al Pastor", readyInMinutes: 35, servings: 1, image: "homemade-tacos-al-pastor-1099851.jpg"
                )
            ]))
        }
    }
    
    func searchIngredients(with params: SearchIngredientsParams,
                           then: (([ResultsIngredients]) -> Void)?,
                           fail: ((Error) -> Void)?) {
        if let callback = then {
            callback( [
                ResultsIngredients(
                    title: "Prosciutto Wrapped Asparagus Cream Cheese – So Easy",
                    usedIngredientCount: 1,
                    image: "https://spoonacular.com/recipeImages/829068-312x231.jpg"
                ),
                ResultsIngredients(
                    title: "Heirloom Tomato, Arugula & Goat Cheese Pizza",   usedIngredientCount: 3, image: "https://spoonacular.com/recipeImages/527651-312x231.jpg"
                ),
                
                ResultsIngredients(
                    title: "Pasta With Chicken and Roasted Red Pepper Cream Sauce", usedIngredientCount: 2, image: "https://spoonacular.com/recipeImages/136802-312x231.jpg"
                )
            ])
        }
    }
    
    func searchVideos(with params: SearchVideosParams,
                      then: ((SearchVideos) -> Void)?,
                      fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(SearchVideos(videos: [
                ResultsVideos(
                    title: "sweet potato and corn soup from scratch  - soup recipes - easy recipe - homemade food - meal prep",
                    length: 342,
                    youTubeId: "un6NUR-5BYY",
                    thumbnail: "https://i.ytimg.com/vi/un6NUR-5BYY/mqdefault.jpg"
                    
                ),
                ResultsVideos(
                    title: "Easy Chicken Tikka Masala",
                    length: 200,
                    youTubeId: "2eI_xPyj2TY",
                    thumbnail: "https://i.ytimg.com/vi/2eI_xPyj2TY/mqdefault.jpg"
                ),
                
                ResultsVideos(
                    title: "easy food recipe | healthy shrimp fried rice | tasty and simple recipes | dinner recipes - homemade",
                    length: 392,
                    youTubeId: "qJi46PON668",
                    thumbnail: "https://i.ytimg.com/vi/qJi46PON668/mqdefault.jpg"
                )
            ]))
        }
    }
}
