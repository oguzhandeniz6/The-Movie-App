//
//  CastView.swift
//  Movie App
//
//  Created by oguzhan.deniz on 27.07.2023.
//

import UIKit

class CastView: UIView {
    
    static let castViewWidth: CGFloat = 100.0
    static let castViewHeight: CGFloat = 190.0
    static let spacing: CGFloat = 4.0

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func fillView(person: Cast) {
        self.personName.text = person.original_name
        self.characterName.text = person.character
        
        if let photo = person.profile_path {
            self.personImageView.kf.setImage(with: NetworkConstants.shared.getMoviePoster(posterPath: photo))
        }
    }
    
    func commonInit() {
        guard let view = Bundle.main.loadNibNamed("CastView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        addSubview(view)
        view.frame = bounds
    }
    
}
