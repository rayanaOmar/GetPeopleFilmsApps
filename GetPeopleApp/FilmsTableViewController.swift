//
//  FilmsTableViewController.swift
//  GetPeopleApp
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmsTableViewController: UITableViewController {
    
    var filmsArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        filmsApi()

        
    }

    // MARK: - Table view data sourc
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filmsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = filmsArray[indexPath.row]

        return cell
    }
    //Function Section
    
    func filmsApi(){
        let filmsAPI = URL(string: "https://swapi.dev/api/films/")
        
        let Session = URLSession.shared
        
        let task = Session.dataTask(with: filmsAPI!, completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with:data!,options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    if let result = jsonResult["results"] as? NSArray {
                        for object in result {
                            if let jsonObject = object as? NSDictionary{
                                self.filmsArray.append(jsonObject["title"] as! String)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
                
            }
        })
        
        task.resume()
    }
}
    
