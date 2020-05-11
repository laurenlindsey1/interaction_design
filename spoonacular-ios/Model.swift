let TESTING_UI = "UI_TESTING"

struct SearchRecipesParams {
    let query: String
}

struct SearchIngredientsParams {
    let ingredients: String
}

struct SearchVideosParams {
    let query: String
}

struct FixedWidth: Codable, Equatable {
    let url: String
}

//search recipe structs
struct ResultsRecipes: Codable, Equatable {
    //    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    
}

struct SearchRecipes: Codable, Equatable {
    let results: [ResultsRecipes]
}

//search by ingredients structs
struct ResultsIngredients: Codable, Equatable {
    let title: String
    let usedIngredientCount: Int
    let image: String
}

struct SearchIngredients: Codable, Equatable {
    let results: [ResultsIngredients]
}


//search videos structs
struct ResultsVideos: Codable, Equatable {
    let title: String
    let length: Int
    let youTubeId: String
    let thumbnail: String
}

struct SearchVideos: Codable, Equatable {
    let videos: [ResultsVideos]
}


