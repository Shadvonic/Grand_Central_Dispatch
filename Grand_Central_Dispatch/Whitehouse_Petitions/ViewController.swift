//
//  ViewController.swift
//  Whitehouse_Petitions
//
//  Created by Marc Moxey on 5/25/22.
//

import UIKit

class ViewController: UITableViewController {

    
    var petitions = [Petition]()// stores all petitions
    var filterPetitions = [Petition]() //stores all filtered petitions
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(giveCredit))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(filter))
        
        
        //fetching json runs on the background
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        
        //url to hit white house api to fetch its data
       // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        let urlString: String
        
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            //live copy
            //urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            //catch copy
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
    
            //convert to URL
            if let url = URL(string: urlString) {
                //covert url to data instance
                if let data = try? Data(contentsOf: url) {
                    //ok to parse data
                    parse(json: data)
                    filterPetitions = petitions
                    return
                }
            }
        
            //run show error on main thread (never do UI work on background thread)
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    
    
    
    @objc func filter() {
        let ac = UIAlertController(title: "Filter petitions by", message: "Search for petition", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] action in guard let filteredWord = ac?.textFields?[0].text else { return }
            self?.submit(filteredWord)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
  
    func submit(_ filteredWord: String) {
        filterPetitions.removeAll(keepingCapacity: true)
        for petition in petitions {
            if petition.title.contains(filteredWord) {
                filterPetitions.append(petition)
                tableView.reloadData()
            }
        }
    }
    
    
    
    @objc func giveCredit() {
        let titleMsg: String
        let msg: String
        
        titleMsg = "Credits"
        msg = "This data comes from We The People API of the Whitehouse"
        
        let ac = UIAlertController(title: titleMsg, message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(ac, animated: true)
    }
    
    
    
    @objc func showError() {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the field please check your connection and try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
    }


    //takes json data
    func parse(json: Data) {
        //create decoder  instance, so we can decode data of our choosing
        let decoder = JSONDecoder()
        //covert to a single Petitions object from our json
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            //assigns the results petitions array
            petitions  = jsonPetitions.results
            //reload data on table view
          
            //reload on main thread
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
         
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //instance of DetailVC class
        let vc = DetailViewController()
        //things to load(whatever one user taps)
        vc.detailItem = petitions[indexPath.row]
        //bring on to screen
        navigationController?.pushViewController(vc, animated: true)
    }
}
