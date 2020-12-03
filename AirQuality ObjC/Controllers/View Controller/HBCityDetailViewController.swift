//
//  HBCityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by Heli Bavishi on 12/2/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class HBCityDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var country: String?
    var state: String?
    var city: String?
    
    //MARK: - Outlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var airQualityIndexLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let state = state, let country = country, let city = city else { return }
        
        HBCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
    }
    
    //MARK: - Helper Methods
    
    func updateViews(with cityDetails: HBCityAirQuality) {
        DispatchQueue.main.async {
            
            self.cityNameLabel.text = "City Name is : \(cityDetails.city)"            
            self.stateLabel.text = "State Name is : \(cityDetails.state)"
            self.countryLabel.text = "Country Name is :\(cityDetails.country)"
            self.temperatureLabel.text = "Temperature is :\(cityDetails.weather.temperature)"
            self.airQualityIndexLabel.text = "Air Quality Index is :\(cityDetails.pollution.airQualityIndex)"
            self.humidityLabel.text = "Humidity is: \(cityDetails.weather.humidity)"
            self.windSpeedLabel.text = "WindSpeed is: \(cityDetails.weather.windSpeed)"
        }
    }
}
