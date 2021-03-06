//
//  ViewController.swift
//  Pokemon
//
//  Created by Miranda Jessie on 11/12/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Make Outlets for the StoryBoard
    @IBOutlet weak var pokemonIDTF: UITextField!
    @IBOutlet weak var pokemonDetailsTV: UITextView!

    //Base URL for request:
    let pokemonIndedx = "https://pokeapi.co/api/v2/pokemon/"
    
    //All the variables that will store information about the pokemon
    var pokeId = ""
    var pokeName = ""
    var pokeAbilities = ""
    var pokeHeight = ""
    var pokeWeight = ""
    var pokeForms = ""
    var pokeArea = ""
    var pokeMoves = ""
    var pokeSpecies = ""
    var pokeStats = ""
    var pokeType = ""
    
    //Add function for the Enter Button:
    @IBAction func enterButtonTapped(_ sender: Any) {
        //Dismissing Keyboard
        pokemonIDTF.resignFirstResponder()
        
        //Checking to make sure the text field has a value
        guard let pokemonID = pokemonIDTF.text else {
            return
        }
        
        //Clearing out textfield
        pokemonIDTF.text = ""
        
        //Replacing spaces in ID with + so they can be used as part of the URL
        let pokemonIDURLComponent = pokemonID.replacingOccurrences(of: " ", with: "+")
        
        //Building our complete request url with name/id
        let requestURL = pokemonIndedx + pokemonIDURLComponent + "/"
        
        //Printing info into view
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.pokemonDetailsTV.text = json.rawString()
                //All the variables that will store information about the pokemon
                var pokeId = json["id"].stringValue
                var pokeNames = json["name"].stringValue
                //Preparing format for organized info
                let format = """
                Name: \(pokeNames.self)
                
                Id: \(pokeId.self)
                Stats:
                Type:
                Species:
                Forms:
                Height:
                Weight:
                Location:
                Moves:
                Abilities:
                """
            //self.infoView.text = format
            case .failure(let error):
                self.pokemonDetailsTV.text = "Invalid selection entered or an error occured. Try again."
                print(error.localizedDescription)
            }
        }
    }
}

    
    
    



