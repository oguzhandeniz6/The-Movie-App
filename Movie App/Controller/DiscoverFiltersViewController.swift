//
//  DiscoverFiltersViewController.swift
//  Movie App
//
//  Created by oguzhan.deniz on 25.08.2023.
//

import UIKit

class DiscoverFiltersViewController: UIViewController {
    
//    Data Sources
    private var genresArray: [Genre] = []
    private let voteArray: [String] = PickerConstants.getVotePickerSource()
    private let yearArray: [String] = PickerConstants.getYearPickerSource()
    private let sortArray: [String] = PickerConstants.getSortPickerSource()
    
//    Filter Variables
    
    var callObject: DiscoverCallObject?
    private var sortType: SortBy = .popularityDesc
    private var voteLeast: Float = 0.0
    private var voteHighest: Float = 10.0
    private var yearLeast: Int = 1874
    private var yearHighest: Int = 2035
    private var selectedGenres: [Genre] = []
    
    
    @IBOutlet weak var voteLabel: UILabel! {
        didSet {
            voteLabel.text = LocalizationHelper.voteLabelName.localizeString()
        }
    }
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            yearLabel.text = LocalizationHelper.yearLabelName.localizeString()
        }
    }
    @IBOutlet weak var sortLabel: UILabel! {
        didSet {
            sortLabel.text = LocalizationHelper.sortLabelName.localizeString()
        }
    }
    
    
    @IBOutlet weak var genresTableView: UITableView!
    
    @IBOutlet weak var votePicker: UIPickerView! {
        didSet {
            preparePickerView(pickerView: votePicker)
            votePicker.selectRow(voteArray.count - 1, inComponent: 1, animated: false)
        }
    }
    
    @IBOutlet weak var yearPicker: UIPickerView! {
        didSet {
            preparePickerView(pickerView: yearPicker)
            yearPicker.selectRow(yearArray.count - 1, inComponent: 1, animated: false)
        }
    }
    
    @IBOutlet weak var sortPicker: UIPickerView! {
        didSet {
            preparePickerView(pickerView: sortPicker)
            sortPicker.selectRow(1, inComponent: 0, animated: false)
        }
    }
    
    @IBOutlet weak var discoverButton: UIButton! {
        didSet {
            discoverButton.setTitle(LocalizationHelper.discoverButtonName.localizeString(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabAndNavBar()
        
        NetworkService.getAllGenres { allGenres in
            self.genresArray = allGenres
            self.prepareTableView()
        }
    }

    
    @IBAction func discoverButtonTapped(_ sender: UIButton) {
        callObject = DiscoverCallObject(pageNumber: 1, minYear: String("\(yearLeast)-01-01"), maxYear: String("\(yearHighest)-01-01"), minVote: voteLeast, maxVote: voteHighest, sortType: sortType, withGenres: FormatChangers.genresFormatToStrWithIDs(gen: selectedGenres))
        
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieListViewController.self)) as? MovieListViewController {
            
            nextVC.callObject = self.callObject
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}

//MARK: - UIPickerViewDataSource

extension DiscoverFiltersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        switch pickerView {
        case votePicker:
            return 2
        case yearPicker:
            return 2
        case sortPicker:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case votePicker:
            return voteArray.count
        case yearPicker:
            return yearArray.count
        case sortPicker:
            return sortArray.count
        default:
            return 0
        }
    }
    
}

//MARK: - UIPickerViewDelegate

extension DiscoverFiltersViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case votePicker:
            return voteArray[row]
        case yearPicker:
            return yearArray[row]
        case sortPicker:
            return sortArray[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case votePicker:
            voteLeast = PickerConstants.setVotePickerFilter(value: pickerView.selectedRow(inComponent: 0))
            voteHighest = PickerConstants.setVotePickerFilter(value: pickerView.selectedRow(inComponent: 1))
        case yearPicker:
            yearLeast = PickerConstants.setYearPickerFilter(value: pickerView.selectedRow(inComponent: 0))
            yearHighest = PickerConstants.setYearPickerFilter(value: pickerView.selectedRow(inComponent: 1))
        case sortPicker:
            sortType = PickerConstants.getSortTypeFromString(sortTypeStr: sortArray[row])
        default:
            break
        }
    }
}

//MARK: - UITableViewDataSource

extension DiscoverFiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let genreCell = tableView.dequeueReusableCell(withIdentifier: GenreCell.getClassName(), for: indexPath) as? GenreCell else {
            return GenreCell()
        }
        
        let genre = genresArray[indexPath.row]
        genreCell.fillCell(genre)
        
        return genreCell
    }
    
    
}

//MARK: - UITableViewDelegate

extension DiscoverFiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGenres.append(genresArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedGenres.removeAll(where: {$0 == genresArray[indexPath.row]})
    }
}

//MARK: - DiscoverFiltersViewController Extension

extension DiscoverFiltersViewController {
    
    private func prepareTableView() {
        genresTableView.delegate = self
        genresTableView.dataSource = self
        genresTableView.register(cell: GenreCell.self)
        genresTableView.allowsMultipleSelection = true
        genresTableView.reloadData()
    }
    
    private func preparePickerView(pickerView: UIPickerView) {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func prepareTabAndNavBar() {
        let appearanceNav = UINavigationBarAppearance()
        appearanceNav.configureWithOpaqueBackground()
        appearanceNav.backgroundColor = UIConstants.mainColor

        self.navigationController?.navigationBar.standardAppearance = appearanceNav
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearanceNav
        
        let appearanceTab = UITabBarAppearance()
        appearanceTab.configureWithOpaqueBackground()
        appearanceTab.backgroundColor = UIConstants.mainColor

        self.tabBarController?.tabBar.standardAppearance = appearanceTab
        if #available(iOS 15.0, *) {
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearanceTab
        }
    }
}
