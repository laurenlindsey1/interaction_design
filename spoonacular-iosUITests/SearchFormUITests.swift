import XCTest

class SearchFormUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        
    }
    
    override func tearDown() {
    }
    
    func testHomePageCheck(){
        XCTAssert(app.buttons["SearchRecipes"].exists)
        XCTAssert(app.buttons["SearchByIngredients"].exists)
        XCTAssert(app.buttons["SearchVideos"].exists)
        
    }
    
    func testNavigateToSearchRecipes() {
        testHomePageCheck()
        app.buttons["SearchRecipes"].tap()
        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
        
        
    }
    
    func testNavigateToSearchIngredients() {
        testHomePageCheck()
        app.buttons["SearchByIngredients"].tap()
        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
        
    }
    
    func testNavigateToSearchVideos() {
        testHomePageCheck()
        app.buttons["SearchVideos"].tap()
        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
        
    }
    
    func testTypeSomethingIntoSearchRecipes() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Search Recipes"]/*[[".buttons[\"SearchRecipes\"].staticTexts[\"Search Recipes\"]",".staticTexts[\"Search Recipes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let searchField = app.textFields["searchTextField"]
        searchField.tap()
        searchField.typeText("testing!")
        searchField.prepareForInterfaceBuilder()
        app.buttons["searchButton"].tap()
        
        
    }
    
    func testTypeSomethingIntoSearchbyIngredients() {
        let app = XCUIApplication()
        app.staticTexts["Search by Ingredients"].tap()
        let searchField = app.textFields["searchTextField"]
        searchField.tap()
        searchField.typeText("testing!")
        searchField.prepareForInterfaceBuilder()
        app.buttons["searchButton"].tap()
    }
    
    func testTypeSomethingIntoSearchVideos() {
        let app = XCUIApplication()
        app.staticTexts["Search Videos"].tap()
        let searchField = app.textFields["searchTextField"]
        searchField.tap()
        searchField.typeText("testing!")
        searchField.prepareForInterfaceBuilder()
        app.buttons["searchButton"].tap()
    }
}
