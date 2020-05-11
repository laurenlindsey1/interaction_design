import UIKit
import SiestaUI


class IngResultsTableViewController: UITableViewController {
    @IBOutlet var searchTable: UITableView!
    
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
        MockApiService() : RealApiService()
    
    var failureCallback: ((Error) -> Void)?
    
    var searchIngredientsParams = SearchIngredientsParams(ingredients: "")
    var searchResultIngredients: [ResultsIngredients] = []
    
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.spoonacular.com/")
        api.searchIngredients(with: searchIngredientsParams, then: display, fail: failureCallback ?? report)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchResultViewController = segue.destination as? SearchResultViewController {
            searchResultViewController.url = searchResultIngredients[selectedRow].image
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "SearchIngTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as! SearchIngTableViewCell
            
            cell.image1.imageURL = self.searchResultIngredients[indexPath.row].image
            cell.title1.text = self.searchResultIngredients[indexPath.row].title
            cell.used1.text = String( self.searchResultIngredients[indexPath.row].usedIngredientCount)
            return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultIngredients.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func display(searchIngredients: [ResultsIngredients]) {
        print("IN DISPLAY FUNCTION")
        searchResultIngredients = searchIngredients
        tableView.reloadData()
    }
    
    func makeURL(image: String) -> String{
        if !image.contains("https"){
            return  "https://spoonacular.com/recipeImages/" + image
        }
        return image
    }
    
    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
                                      message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
