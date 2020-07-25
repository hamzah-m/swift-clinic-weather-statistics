//
//  ViewController.swift
//  WeatherStatistics
//
//  Created by Hamzah Mugharbil on 7/21/20.
//  Copyright © 2020 Hamzah Mugharbil. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var meanTemp: UILabel!
    @IBOutlet weak var medianTemp: UILabel!
    @IBOutlet weak var meanPressure: UILabel!
    @IBOutlet weak var medianPressure: UILabel!
    @IBOutlet weak var meanSpeed: UILabel!
    @IBOutlet weak var medianSpeed: UILabel!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var realm: Realm!
    
    @IBAction func startDateChanged(_ sender: UIDatePicker) {
        if startDate.date >= endDate.date {
            endDate.date = startDate.date
        }
    }
    
    @IBAction func endDateChanged(_ sender: UIDatePicker) {
        if startDate.date >= endDate.date {
            startDate.date = endDate.date
        }
    }
    
    @IBAction func updateDateRange(_ sender: UIButton) {
        activityView.isHidden = false
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.updateDays()
            self.activityView.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.isHidden = true
        loadRealm()
    }
    
    private func updateDays() {
        
    }
    
    private func showMessage(message: String) {
        let alert = UIAlertController(title: "Missing Data", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func findMean(a: [Double]) -> Double {
        return 0
    }
    
    private func findMedian(a: [Double]) -> Double {
        return 0
    }
    
    func loadRealm() {
        do {
            let fileManager = FileManager.default
            let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("DayData.realm")
            let bundleURL = Bundle.main.url(forResource: "DayData", withExtension: "realm")
            
            if !fileManager.fileExists(atPath: docURL.path) {
                try fileManager.copyItem(at: bundleURL!, to: docURL)
            }
            
            var config = Realm.Configuration()
            config.objectTypes = [DayData.self]
            config.fileURL = docURL
            realm = try Realm(configuration: config)
        } catch {
            print(error)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

