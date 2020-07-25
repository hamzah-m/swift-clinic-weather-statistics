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
    
    func findAverages(_ data: Results<DayData>) {
        var temps: [Double] = []
        var speeds: [Double] = []
        var pressures: [Double] = []
        
        for day: DayData in data {
            temps.append(day.AirTemp.value!)
            speeds.append(day.WindSpeed.value!)
            pressures.append(day.BarometricPress.value!)
        }
        
        medianTemp.text = "\(findMedian(a: temps))"
        meanTemp.text = "\(findMean(a: temps))"
        meanPressure.text = "\(findMedian(a: pressures))"
        medianPressure.text = "\(findMean(a: pressures))"
        medianSpeed.text = "\(findMedian(a: speeds))"
        meanSpeed.text = "\(findMean(a: speeds))"
    }
    
    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Missing Data", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func findMean(a: [Double]) -> Double {
        var total: Double = 0
        for num in a {
            total += num
        }
        return total/Double(a.count)
    }
    
    private func findMedian(a: [Double]) -> Double {
        let aSorted = a.sorted()
        if aSorted.count % 2 == 0 {
            let midIndex = aSorted.count/2 - 1
            return findMean(a: [aSorted[midIndex], aSorted[midIndex + 1]])
        }
        let midIndex = Int(floor(Float(aSorted.count)/2.0))
        return aSorted[midIndex]
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
        
        updateDays()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
 
    private func updateDays() {
        let d1 = startDate.date
        let d2 = endDate.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let startDate = Int(formatter.string(from: d1))!
        let endDate = Int(formatter.string(from: d2))!
        let data: Results<DayData> = realm.objects(DayData.self).filter("date >= \(startDate) AND date <= \(endDate)")
        
        if data.count < 2 {
            showMessage("Insufficient data. Please change start and/or end date.")
            return
        }
        
        let dataForStartDate = (data[0].date.value! == startDate)
        let dataForEndDate = (data.last!.date.value! == endDate)
        
        if !dataForStartDate {
            showMessage("No data for start date.")
        }
        
        if !dataForEndDate {
            showMessage("No data for end date.")
        }
        
        findAverages(data)
    }
}

