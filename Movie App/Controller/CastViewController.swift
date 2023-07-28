//
//  CastViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.07.2023.
//

import UIKit

class CastViewController: UIViewController {
    
    var actorID: Int = 0
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorPhotoImageView: UIImageView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deathdayLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    @IBOutlet weak var bioView: UIView! {
        didSet {
            bioView.layer.cornerRadius = 30
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCall()
    }
    
    func networkCall() {
        NetworkManager.shared.fetchDataObject(
            urlString: NetworkConstants.shared.getPersonDetails(personID: actorID),
            dataType: Actor.self, completion: { result in
                self.preparePage(actor: result)
            })
    }
    
    func preparePage(actor: Actor) {
        actorNameLabel.text = actor.name
        birthdayLabel.text = Utilities.dateFormatChanger(str: actor.birthday ?? "")
        deathdayLabel.text = Utilities.dateFormatChanger(str: actor.deathday ?? "")
        birthPlaceLabel.text = actor.place_of_birth
        bioLabel.text = actor.biography
        actorPhotoImageView.kf.setImage(with: NetworkConstants.shared.getMoviePoster(posterPath: actor.profile_path ?? ""))
    }
}
