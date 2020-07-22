//
//  ViewController.swift
//  WeatherStatistics
//
//  Created by Hamzah Mugharbil on 7/21/20.
//  Copyright © 2020 Hamzah Mugharbil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var airTemp: UILabel!
    @IBOutlet weak var barPressure: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var relHumidity: UILabel!
    @IBOutlet weak var windDir: UILabel!
    @IBOutlet weak var windGust: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBAction func updateDateRange(_ sender: UIButton) {
        print("Start date: \(startDate.date)")
        print("End date: \(endDate.date)")
        airTemp.text = "some other value"
        barPressure.text = "some other value some other value"
        dewPoint.text = "some other value some other value"
        relHumidity.text = "some other value some other value"
        windDir.text = "some other value some other value"
        windGust.text = "some other value some other value"
        windSpeed.text = "some other value some other value"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInitialValues()

    }
    
    private func loadInitialValues() {
        airTemp.text = "potato"
        barPressure.text = "some value"
        dewPoint.text = "some value"
        relHumidity.text = "some value"
        windDir.text = "some value"
        windGust.text = "some value"
        windSpeed.text = "some value"
    }

}

