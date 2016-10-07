//
//  CountryWebViewController.swift
//  Countries
//
//  Created by CS3714 on 10/6/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit



class CountryWebViewController: UIViewController, UIWebViewDelegate {
    
    
    
    // Instance variable holding the object reference of the Web View UI object
    
    @IBOutlet var countryWeb: UIWebView!
    
    
    
    // websiteURL and countryName are set by the upstream view controller
    
    var websiteURL: String = ""
    
    var countryName: String = ""
    
    
    
    /*
     
     -----------------------
     
     MARK: - View Life Cycle
     
     -----------------------
     
     */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Display the selected country name on the navigation bar
        
        self.title = countryName
        
        
        
        // Obtain the URL structure instance from the given websiteURL
        
        let url = URL(string: websiteURL)
        
        
        
        // Obtain the URLRequest structure instance from the given url
        
        let request = URLRequest(url: url!)
        
        
        
        // Ask the web view object to display the web page for the requested URL
        
        countryWeb.loadRequest(request)
        
    }
    
    
    
    /******************************************************************************************
     
     * UIWebView Delegate Methods: These methods must be implemented whenever UIWebView is used.
     
     ******************************************************************************************/
    
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        // Starting to load the web page. Show the animated activity indicator in the status bar
        
        // to indicate to the user that the UIWebVIew object is busy loading the web page.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // Finished loading the web page. Hide the activity indicator in the status bar.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        /*
         
         Ignore this error if the page is instantly redirected via javascript or in another way.
         
         NSURLErrorCancelled is returned when an asynchronous load is cancelled, which happens
         
         when the page is instantly redirected via javascript or in another way.
         
         */
        
        if (error as NSError).code == NSURLErrorCancelled  {
            
            return
            
        }
        
        
        
        // An error occurred during the web page load. Hide the activity indicator in the status bar.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
        
        // Create the error message in HTML as a character string and store it into the local constant errorString
        
        let errorString = "<html><font size=+2 color='red'><p>An error occurred: <br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>" + error.localizedDescription
        
        
        
        // Display the error message within the UIWebView object
        
        // self. is required here since this method has a parameter with the same name.
        
        countryWeb.loadHTMLString(errorString, baseURL: nil)
        
    }
    
    
    
}
