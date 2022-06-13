//
//  DetailViewController.swift
//  Whitehouse_Petitions
//
//  Created by Marc Moxey on 5/25/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //check if detailItem exists
        guard let detailItem = detailItem else {return}
        
        //place body into html body
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        //custom html string made by head to be loaded
        webView.loadHTMLString(html, baseURL: nil)
    }
    


}
