import UIKit
import SiestaUI
import SafariServices

class VidResultsTableViewController: UITableViewController {
    @IBOutlet var searchTable: UITableView!
    
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
        MockApiService() : RealApiService()
    
    var failureCallback: ((Error) -> Void)?
    var searchVideosParams = SearchVideosParams(query: "")
    var searchResultVideos: [ResultsVideos] = []
    var numResults: Int = 0
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.spoonacular.com/")
        
        api.searchVideos(with: searchVideosParams, then: display, fail: failureCallback ?? report)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchResultViewController = segue.destination as? SearchResultViewController {
            searchResultViewController.url = searchResultVideos[selectedRow].thumbnail
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let youtubeCode =  self.searchResultVideos[indexPath.row].youTubeId
        if let url = URL(string: "https://www.youtube.com/watch?v=" + youtubeCode) {
            UIApplication.shared.open(url)
        }
    }
    
    func grabId(id: String) -> String{
        return id;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cellIdentifier = "SearchVideoTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as! SearchVidTableViewCell
            
            cell.image1.imageURL = self.searchResultVideos[indexPath.row].thumbnail
            cell.title1.text = self.searchResultVideos[indexPath.row].title
            cell.length1.text = secondsToMinutes(length: self.searchResultVideos[indexPath.row].length)
            return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultVideos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func display(searchVideos: SearchVideos) {
        searchResultVideos = searchVideos.videos
        tableView.reloadData()
    }
    
    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
                                      message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func secondsToMinutes(length: Int) -> String {
        let minutes = length / 60
        let seconds = length - (minutes * 60)
        if String(seconds).count < 2 {
            return String(minutes) + ":" +  String(seconds) + "0"
        }
        return String(minutes) + ":" +  String(seconds)
    }
}
