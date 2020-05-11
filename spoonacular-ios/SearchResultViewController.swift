import UIKit
import WebKit

class SearchResultViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    var url: String? {
        didSet {
            if self.isViewLoaded {
                self.refreshWebView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        refreshWebView()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.progress = 0.25
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        progressView.progress = 0.75
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.progress = 1.0
        DispatchQueue.main.async { [weak self] in
            self?.progressView.isHidden = true
        }
    }
    
    private func refreshWebView() {
        guard let urlString = url else {
            return
        }
        
        let html = """
        <!doctype html>
        <html>
        <head>
        <title>Image</title>
        <meta charset="utf-8" />
        <style>
        body {
        margin: 0;
        padding: 0;
        }
        
        img {
        width: 100vw;
        }
        </style>
        </head>
        <body>
        <img src="\(urlString)" alt="image" />
        </body>
        </html>
        """
        
        progressView.progress = 0.0
        progressView.isHidden = false
        webView.loadHTMLString(html, baseURL: nil)
    }
}
