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
            spiderChartView.items = [ItemView(value: 0.6, isSet: false),
                                     ItemView(value: 0.8, isSet: true),
                                     ItemView(value: 1.0, isSet: false),
                                     ItemView(value: 0.6, isSet: true),
                                     ItemView(value: 0.9, isSet: true),
                                     ItemView(value: 0.6, isSet: false)]
            
            spiderChartView.circleCount = 10
        default:
            view.backgroundColor = .white
            spiderChartView.color = .darkGray
            spiderChartView.items = [ItemView(value: 0.6, isSet: false),
                                     ItemView(value: 0.8, isSet: true),
                                     ItemView(value: 1.0, isSet: false)]
            return
        }
    }

}

class ItemView: SpiderChartItem {
    var view: UIView
    var value: Float
    var isSet: Bool
    
    init(value: Float, isSet: Bool) {
        self.value = value
        self.isSet = isSet
        view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: 80, height: 20))
        view.addSubview(label)
        label.text = "hello"
    }
}

