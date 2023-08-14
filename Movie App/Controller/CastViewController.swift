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
        
        NetworkService.getActorDetails(actorID: actorID, castVC: self)
    }
    
    func preparePage(actor: Actor) {
        actorNameLabel.text = actor.name
        birthdayLabel.text = FormatChangers.dateFormatChanger(str: actor.birthday ?? "")
        
        if actor.deathday != nil {
            deathdayLabel.text = FormatChangers.dateFormatChanger(str: actor.deathday ?? "")
        } else {
            deathdayLabel.text = ""
        }
        
        birthPlaceLabel.text = actor.place_of_birth
        bioLabel.text = "\n\(actor.biography ?? "")"
        actorPhotoImageView.kf.setImage(with: NetworkConstants.getMovieImageURL(posterPath: actor.profile_path ?? "", imageSize: ProfileSize.original.rawValue))
    }
}
