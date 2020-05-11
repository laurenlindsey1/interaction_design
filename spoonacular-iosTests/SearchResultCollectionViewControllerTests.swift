import XCTest
@testable import spoonacular_ios

class SearchResultCollectionViewControllerTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testRecipesShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let recResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RecResultsTableViewController")
            as? RecResultsTableViewController else {
                XCTFail()
                return
        }
        
        recResultsTableViewController.searchResultRecipes =  [
            ResultsRecipes(
                title: "Skinny Chicken & Broccoli Alfredo", readyInMinutes: 25,servings: 4, image: "https://d32dm0rphc51dk.cloudfront.net/u28mOc02a2H6pFFjv07ogg/four_thirds.jpg"
            ),
            ResultsRecipes(
                title: "Perfect Scalloped Potatoes", readyInMinutes: 90,servings: 2, image: "https://spoonacular.com/recipeImages/829068-312x231.jpg"
            ),
            
            ResultsRecipes(
                title: "Homemade Tacos Al Pastor", readyInMinutes: 35, servings: 1, image: "https://spoonacular.com/recipeImages/829068-312x231.jpg"
            )
        ]
        
        guard let tableView = recResultsTableViewController.tableView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(1, recResultsTableViewController.numberOfSections(in: tableView))
        XCTAssertEqual(3, recResultsTableViewController.tableView(tableView, numberOfRowsInSection: 0))
    }
    
    func testIngredientsShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let ingResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "IngResultsTableViewController")
            as? IngResultsTableViewController else {
                XCTFail()
                return
        }
        
        ingResultsTableViewController.searchResultIngredients =  [
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
        ]
        guard let tableView = ingResultsTableViewController.tableView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(1, ingResultsTableViewController.numberOfSections(in: tableView))
        XCTAssertEqual(3, ingResultsTableViewController.tableView(tableView, numberOfRowsInSection: 0))
    }
    
    
    func testVideosShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let vidResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "VidResultsTableViewController")
            as? VidResultsTableViewController else {
                XCTFail()
                return
        }
        
        vidResultsTableViewController.searchResultVideos =  [
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
        ]
        
        guard let tableView = vidResultsTableViewController.tableView else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(1, vidResultsTableViewController.numberOfSections(in: tableView))
        XCTAssertEqual(3, vidResultsTableViewController.tableView(tableView, numberOfRowsInSection: 0))
    }
    
    func testShouldTriggerRecipeSearchWhenSearchResultCollectionViewControllerLoads() {
        guard let recResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RecResultsTableViewController")
            as? RecResultsTableViewController else {
                XCTFail()
                return
        }
        
        recResultsTableViewController.api = TestApiService()
        recResultsTableViewController.searchRecipesParams = SearchRecipesParams(query: "hello")
        recResultsTableViewController.viewDidLoad()
        // Asserts are in the TestApiService implementation, see below.
    }
    
    func testShouldTriggerIngredientSearchWhenSearchResultCollectionViewControllerLoads() {
        guard let ingResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "IngResultsTableViewController")
            as? IngResultsTableViewController else {
                XCTFail()
                return
        }
        
        ingResultsTableViewController.api = TestApiService()
        ingResultsTableViewController.searchIngredientsParams = SearchIngredientsParams(ingredients: "hello")
        ingResultsTableViewController.viewDidLoad()
    }
    
    func testShouldTriggerVideoSearchWhenSearchResultCollectionViewControllerLoads() {
        guard let vidResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "VidResultsTableViewController")
            as? VidResultsTableViewController else {
                XCTFail()
                return
        }
        
        vidResultsTableViewController.api = TestApiService()
        vidResultsTableViewController.searchVideosParams = SearchVideosParams(query: "hello")
        vidResultsTableViewController.viewDidLoad()
    }
    
    func testRecShouldDisplayAlertWhenAPICallFails() {
        guard let recResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RecResultsTableViewController")
            as? RecResultsTableViewController else {
                XCTFail()
                return
        }
        
        var failureCallbackWasCalled = false
        recResultsTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }
        
        recResultsTableViewController.api = FailingApiService()
        recResultsTableViewController.searchRecipesParams = SearchRecipesParams( query: "hello")
        recResultsTableViewController.viewDidLoad()
        
        XCTAssert(failureCallbackWasCalled)
    }
    
    func testIngShouldDisplayAlertWhenAPICallFails() {
        guard let ingResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "IngResultsTableViewController")
            as? IngResultsTableViewController else {
                XCTFail()
                return
        }
        
        var failureCallbackWasCalled = false
        ingResultsTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }
        
        ingResultsTableViewController.api = FailingApiService()
        ingResultsTableViewController.searchIngredientsParams = SearchIngredientsParams(ingredients: "hello")
        ingResultsTableViewController.viewDidLoad()
        
        XCTAssert(failureCallbackWasCalled)
    }
    
    func testVidShouldDisplayAlertWhenAPICallFails() {
        guard let vidResultsTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "VidResultsTableViewController")
            as? VidResultsTableViewController else {
                XCTFail()
                return
        }
        
        var failureCallbackWasCalled = false
        vidResultsTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }
        
        vidResultsTableViewController.api = FailingApiService()
        vidResultsTableViewController.searchVideosParams = SearchVideosParams( query: "hello")
        vidResultsTableViewController.viewDidLoad()
        
        XCTAssert(failureCallbackWasCalled)
    }
}

class TestApiService: Api {
    func api(host: String) {
    }
    
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.query, "hello")
    }
    
    func searchIngredients(with params: SearchIngredientsParams,
                           then: (([ResultsIngredients]) -> Void)?,
                           fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.ingredients, "hello")
    }
    
    func searchVideos(with params: SearchVideosParams,
                      then: ((SearchVideos) -> Void)?,
                      fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.query, "hello")
    }
}

class FailingApiService: Api {
    func api(host: String) {
    }
    
    func searchRecipes(with params: SearchRecipesParams,
                       then: ((SearchRecipes) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = fail {
            callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    
    func searchIngredients(with params: SearchIngredientsParams, then: (([ResultsIngredients]) -> Void)?, fail: ((Error) -> Void)?) {
        if let callback = fail {
            callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    
    func searchVideos(with params: SearchVideosParams, then: ((SearchVideos) -> Void)?, fail: ((Error) -> Void)?) {
        if let callback = fail {
            callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
        
    }
}
