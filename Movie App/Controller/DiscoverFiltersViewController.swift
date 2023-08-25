//
//  DiscoverFiltersViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.08.2023.
//

import UIKit

class DiscoverFiltersViewController: UIViewController {
    
    @IBOutlet weak var genresTableView: UITableView!
    
    @IBOutlet weak var lowerLimitVotePicker: UIPickerView!
    @IBOutlet weak var higherLimitVotePicker: UIPickerView!
    
    @IBOutlet weak var lowerLimitYearPicker: UIPickerView!
    @IBOutlet weak var higherLimitYearPicker: UIPickerView!
    
    @IBOutlet weak var sortPicker: UIPickerView!
    
    @IBOutlet weak var discoverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func discoverButtonTapped(_ sender: UIButton) {
    }
    
}

//MARK: - UIPickerViewDataSource

extension DiscoverFiltersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case lowerLimitVotePicker, higherLimitVotePicker:
            return 10
        case lowerLimitYearPicker, higherLimitYearPicker:
            return 10
        case sortPicker:
            return 10
        default:
            return 0
        }
    }
    
    
}
