//
//  HBCitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class HBCitiesListViewController: UIViewController {

    //MARK: - Properties
    
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    //MARK: - Outlets
    
    @IBOutlet weak var cityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        guard let state = state, let country = country else { return }
        HBCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailVC"
        {
            guard let indexPath = cityTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? HBCityDetailViewController
            else { return }
            
            let selectedCity = cities[indexPath.row]
            destinationVC.country = country
            destinationVC.state = state
            destinationVC.city = selectedCity
        }
    }
    
    //MARK: - Helper Methods
    func updateTableView() {
        DispatchQueue.main.async {
            self.cityTableView.reloadData()
        }
    }

}// End of class

extension HBCitiesListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    
}
