//
//  HBCountriesListViewController.swift
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class HBCountriesListViewController: UIViewController {
    
    //MARK: - Properties
    
    var countries: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var countryTableView: UITableView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTableView.delegate = self;
        countryTableView.dataSource = self;
        
        HBCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC"
        {
            guard let indexPath = countryTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? HBStatesListViewController
            else { return }
            
            let selectedCountry = countries[indexPath.row]
            destinationVC.country = selectedCountry
        }
    }
    
    //MARK: - Helper Function
    func updateTableView() {
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
    }
}

extension HBCountriesListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country
        return cell
    }
    
    
}
