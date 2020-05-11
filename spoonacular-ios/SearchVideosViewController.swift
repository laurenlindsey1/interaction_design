//
//  SearchVideosVideoController.swift
//  spoonacular
//

import UIKit

class SearchVideosViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var searchVideosParams = SearchVideosParams(query: "")
    var failureCallbackRecipes: ((Error) -> Void)?
    
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
        MockApiService(): ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vidResultsTableViewController = segue.destination as? VidResultsTableViewController,
            let query = searchTextField.text {
            vidResultsTableViewController.searchVideosParams = SearchVideosParams(query: query)
        }
    }
    
    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
                                      message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func textFieldChanged(_ sender: Any) {
        updateViews()
    }
    
    
    private func updateViews() {
        searchButton?.isEnabled = (searchTextField?.text ?? "").count > 0
    }
}
