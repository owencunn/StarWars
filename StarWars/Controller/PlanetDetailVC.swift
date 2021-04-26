//
//  PlanetDetailVC.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/04/25.
//

import UIKit

class PlanetDetailVC: UIViewController {

    @IBOutlet weak var diameterLbl: UILabel!
    @IBOutlet weak var rotationPeriodLbl: UILabel!
    @IBOutlet weak var orbitalPeriodLbl: UILabel!
    @IBOutlet weak var gravityLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var surfaceWaterLbl: UILabel!
    @IBOutlet weak var residentsLbl: UILabel!
    @IBOutlet weak var filmsLbl: UILabel!
    
    
    var planet = Planet(name: "", diameter: "", rotation_period: "", orbital_period: "", gravity: "", population: "", climate: "", terrain: "", surface_water: "", residents: [""], films: [""], url: "", created: "", edited: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = planet.name
        
        diameterLbl.text = planet.diameter + " km"
        rotationPeriodLbl.text = (planet.rotation_period != "unknown") ? planet.rotation_period + " hrs" :  planet.rotation_period
        orbitalPeriodLbl.text = (planet.orbital_period != "unknown") ? planet.orbital_period + " days" :  planet.orbital_period
        gravityLbl.text = (planet.gravity != "unknown") ? planet.gravity + " G" :  planet.gravity
        populationLbl.text = planet.population
        climateLbl.text = planet.climate
        terrainLbl.text = planet.terrain
        surfaceWaterLbl.text = (planet.surface_water != "unknown") ? planet.surface_water + " %" :  planet.surface_water
        residentsLbl.text = String(planet.residents.count)
        
        
        var filmList = ""
        for film in planet.films {
            if film.contains("1") {
                filmList = filmList + "I"
            } else if film.contains("2") {
                filmList = filmList + "II"
            } else if film.contains("3") {
                filmList = filmList + "III"
            } else if film.contains("4") {
                filmList = filmList + "IV"
            } else if film.contains("5") {
                filmList = filmList + "V"
            } else {
                filmList = filmList + "VI"
            }
            if film != planet.films.last { //if not last element, add a comma seperator
              filmList = filmList + ", "
            }
        }
        if filmList == "" { //
            filmList = "0"
        }
        filmsLbl.text = filmList
    }
    
    func initPlanetDetails(planet: Planet) {
        //receive character from PeopleVC
        self.planet = planet
    }

}
