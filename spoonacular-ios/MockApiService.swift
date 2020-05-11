import Foundation

class MockApiService: Api {
    func api(host: String) {
    }
    
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(SearchRecipes(results: [
                ResultsRecipes(
                    title: "Skinny Chicken & Broccoli Alfredo", readyInMinutes: 25, servings: 4, image: "https://d32dm0rphc51dk.cloudfront.net/u28mOc02a2H6pFFjv07ogg/four_thirds.jpg"
                )
            ]))
        }
    }
    
    func searchIngredients(with params: SearchIngredientsParams,
                           then: (([ResultsIngredients]) -> Void)?,
                           fail: ((Error) -> Void)?) {
        if let callback = then {
            callback([
                ResultsIngredients(
                    title: "Prosciutto Wrapped Asparagus Cream Cheese – So Easy",
                    usedIngredientCount: 1,
                    image: "https://spoonacular.com/recipeImages/829068-312x231.jpg"
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
                    title: "easy food recipe | healthy shrimp fried rice | tasty and simple recipes | dinner recipes - homemade",
                    length: 392,
                    youTubeId: "qJi46PON668",
                    thumbnail: "https://i.ytimg.com/vi/qJi46PON668/mqdefault.jpg"
                )
            ]))
        }
    }
}
