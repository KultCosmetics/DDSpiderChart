//
//  ViewController.swift
//  DDSpiderChart
//
//  Created by dadalar on 05/01/2017.
//  Copyright (c) 2017 dadalar. All rights reserved.
//

import UIKit
import DDSpiderChart

class ViewController: UIViewController {

    @IBOutlet weak var spiderChartView: DDSpiderChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAxisData(sampleIndex: 0)
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        loadAxisData(sampleIndex: sender.selectedSegmentIndex)
    }

    func attributedAxisLabelSample2(_ label: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: label, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-Bold", size: 16)!]))
        return attributedString
    }

    func loadAxisData(sampleIndex: Int) {
        switch sampleIndex {
        case 0:
            view.backgroundColor = .white
            spiderChartView.color = UIColor(red: 0.914, green: 0.914, blue: 0.914, alpha: 1)
            spiderChartView.concerns = ["PAS", "DRI", "SPD", "DEF", "PHY", "DEF"]
            spiderChartView.addDataSet(values: [0.6, 0.8, 1.0, 0.6, 0.9,  0.6], color: UIColor(red: 0.518, green: 0.827, blue: 0.753, alpha: 0.25))
            spiderChartView.circleCount = 10
        default:
            view.backgroundColor = .white
            spiderChartView.color = .darkGray
            spiderChartView.concerns = ["E-mail", "Facebook", "Twitter"]
            spiderChartView.addDataSet(values: [0.8, 0.8, 1.0], color: UIColor(red:1.00, green:0.54, blue:0.00, alpha:1.0))
            return
        }
    }

}

