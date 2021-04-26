//
//  ViewController.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/03/25.
//

import UIKit

class CharacterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var peopleTable: UITableView!
  //  @IBOutlet weak var personLbl: UILabel!
    
    var results = [Result]()
    var url =  "\(NetworkService.shared.URL_BASE)\(NetworkService.shared.URL_PEOPLE)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleTable.delegate = self
        peopleTable.dataSource = self
        
        getPeople()
  
    }
    
    func getPeople() {
        NetworkService.shared.getPeople(onSuccess: { (people) in
            self.results.append(contentsOf: people.results)
            
            //if next has a value set it to current url
            if people.next != nil {
                self.url = people.next!
            } else {
                self.url = ""
            }

            self.peopleTable.reloadData()

            //self.navigationItem.title = "Star Wars Characters \(self.results.count)"
            self.navigationItem.title = "\(self.results.count) of \(people.count) characters loaded"
            
        }, onError: { (errorMessage) in
            debugPrint(errorMessage)
        }, urlStringType: url)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? PersonCell {
            cell.updateCell(person: results[indexPath.row])
            
            // load more characters as required
            if indexPath.row == results.count-1 && self.url != "" {
                //print("URL: \(url)")
                self.getPeople()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = results[indexPath.row]
        performSegue(withIdentifier: "CharacterDetailVC", sender: character)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let characterDetailVC = segue.destination as? CharacterDetailVC {
            assert(sender as? Result != nil)
            characterDetailVC.initCharacterDetails(result: sender as! Result)
        }
    }
 
    
}

/*
 PROJECT
 
 - Create a tableview that shows a list of StarWars character's names
 - Tapping that star wars character name opens up a details view about them. You must include the homeworld if there is one
 - Make the homeworld tappable - and tapping it will open another screen showing information about that planet
 - All of this data must come from the API and not be hard coded in the app
 
 */
