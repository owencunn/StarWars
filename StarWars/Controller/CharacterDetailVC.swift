//
//  CharacterDetailVC.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/04/22.
//

import UIKit

class CharacterDetailVC: UIViewController {

    @IBOutlet weak var characterView: UIView!
    
    @IBOutlet weak var birthYrLbl: UILabel!
    @IBOutlet weak var eyeClorLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var hairColorLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var skinColorLbl: UILabel!

    @IBOutlet weak var homeworldBtn: UIButton!
    
    var url = ""
    var planet = Planet(name: "", diameter: "", rotation_period: "", orbital_period: "", gravity: "", population: "", climate: "", terrain: "", surface_water: "", residents: [""], films: [""], url: "", created: "", edited: "")
    
    private(set) public var character = Result(name: "", birth_year: "", eye_color: "", gender: "", hair_color: "", height: "", mass: "", skin_color: "", homeworld: "", films: [""], species: [""], starships: [""], vehicles: [""], url: "", created: "", edited: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = character.name
        
        url = character.homeworld
        
        birthYrLbl.text = character.birth_year
        eyeClorLbl.text = character.eye_color
        genderLbl.text = character.gender
        hairColorLbl.text = character.hair_color
        heightLbl.text = character.height
        massLbl.text = character.mass
        skinColorLbl.text = character.skin_color
        
        homeworldBtn.setTitle(character.homeworld, for: .normal)
        
        getPlanet()
        
    }

    func initCharacterDetails(result: Result) {
        //receive character from PeopleVC
        character = result
    }
    
    func getPlanet() {
        NetworkService.shared.getPlanet(onSuccess: { (planet) in
            
            if planet.name != "unknown" {
                self.homeworldBtn.setTitle(planet.name, for: .normal)
                self.homeworldBtn.isEnabled = true
            } else {
                self.homeworldBtn.setTitle("unknown", for: .normal)
                self.homeworldBtn.isEnabled = false
            }
            self.planet = planet
            //print(planet)
            
        }, onError: { (errorMessage) in
            debugPrint(errorMessage)
        }, urlStringType: url)
    }
    
    @IBAction func homeworldBtnPressed(_ sender: Any) {
        //load new view controller
        self.performSegue(withIdentifier: "PlanetDetailVC", sender: self.planet)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let planetDetailVC = segue.destination as? PlanetDetailVC {
            assert(sender as? Planet != nil)
            planetDetailVC.initPlanetDetails(planet: sender as! Planet)
        }
    }
    
}
