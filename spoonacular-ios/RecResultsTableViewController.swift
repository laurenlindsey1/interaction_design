import UIKit
import SiestaUI
import SafariServices

class RecResultsTableViewController: UITableViewController {
    @IBOutlet var searchTable: UITableView!
    
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
        MockApiService() : RealApiService()
    
    var failureCallback: ((Error) -> Void)?
    
    var searchRecipesParams = SearchRecipesParams(query: "")
    var searchResultRecipes: [ResultsRecipes] = []
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.spoonacular.com/")
        api.searchRecipes(with: searchRecipesParams, then: display, fail: failureCallback ?? report)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchResultViewController = segue.destination as? SearchResultViewController {
            searchResultViewController.url = searchResultRecipes[selectedRow].image
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            let cellIdentifier = "SearchResultTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as! SearchRecTableViewCell
            
            cell.image1.imageURL = makeURL(image: self.searchResultRecipes[indexPath.row].image)
            cell.servings1.text = "Servings: " + String(self.searchResultRecipes[indexPath.row].servings)
            cell.title1.text = self.searchResultRecipes[indexPath.row].title
            cell.minutes1.text = convertToHours(time: self.searchResultRecipes[indexPath.row].readyInMinutes)
            
            return cell
    }
    func makeURL(image: String) -> String{
        if !image.contains("https"){
            return  "https://spoonacular.com/recipeImages/" + image
        }
        return image
    }
    
    func convertToHours(time: Int) -> String{
        let hours = time / 60
        let minutes = time - (hours * 60)
        if hours == 0{
            return String(minutes) + " minutes"
        }
        else{
            return String(hours) + " hours " +  String(minutes) + " minutes"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultRecipes.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func display(searchRecipes: SearchRecipes) {
        searchResultRecipes = searchRecipes.results
        tableView.reloadData()
    }
    
    
    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
                                      message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
