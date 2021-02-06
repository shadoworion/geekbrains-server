//
//  VKLoginController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit
import WebKit

class VKLoginController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView.navigationDelegate = self
        webView.uiDelegate = self

        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7753324"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "scope", value: "friends,photos,wall,groups"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.126")
                ]
                
        if let requestUrl = urlComponents.url {
            let request = URLRequest(url: requestUrl)
            webView.load(request)
        }
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = String(params["access_token"] ?? "undefined")
        let userId = Int(params["user_id"] ?? "0") ?? 0
        
        if token != "undefined" && userId != 0 {
            let session = UserSession.shared
            session.token = token
            session.userId = userId
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBar = storyBoard.instantiateViewController(withIdentifier: "MainTabBar")
            self.show(mainTabBar, sender: self)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Something wrong! Try later...", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        decisionHandler(.cancel)
    }
    
    @IBAction func returnToView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
