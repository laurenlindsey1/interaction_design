import Siesta

class RealApiService: Api {
    
    
    let API_KEY = "089265b00c3b4342abd371530db4c641"
    
    private var service = Service(
        baseURL: "https://api.spoonacular.com",
        standardTransformers: [.text, .image])
    
    init() {
        SiestaLog.Category.enabled = [.network]
    }
    
    func api(host: String) {
        service = Service(baseURL: host, standardTransformers: [.text, .image])
        
        let jsonDecoder = JSONDecoder()
        service.configureTransformer("/recipes/search") {
            try jsonDecoder.decode(SearchRecipes.self, from: $0.content)
        }
        service.configureTransformer("/recipes/findByIngredients") {
            try jsonDecoder.decode([ResultsIngredients].self, from: $0.content)
        }
        service.configureTransformer("/food/videos/search") {
            try jsonDecoder.decode(SearchVideos.self, from: $0.content)
        }
        
    }
    
    
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?) {
        service.resource("/recipes/search") 
            .withParam("apiKey", API_KEY)
            .withParam("query", params.query)
            
            .request(.get).onSuccess { result in
                if let searchResult: SearchRecipes = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
    
    func searchIngredients(with params: SearchIngredientsParams, then: (([ResultsIngredients]) -> Void)?, fail: ((Error) -> Void)?) {
        service.resource("/recipes/findByIngredients")
            .withParam("apiKey", API_KEY)
            .withParam("ingredients", params.ingredients)
            .request(.get).onSuccess { result in
                if let searchResult: [ResultsIngredients] = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
    
    func searchVideos(with params: SearchVideosParams, then: ((SearchVideos) -> Void)?, fail: ((Error) -> Void)?) {
        service.resource("/food/videos/search")
            .withParam("apiKey", API_KEY)
            .withParam("query", params.query)
            
            .request(.get).onSuccess { result in
                if let searchResult: SearchVideos = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
    
}
