//
//  CharacterCell.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/03/25.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var personLbl: UILabel!
    
    func updateCell(person: Result) {
        personLbl.text = person.name
    }
}
