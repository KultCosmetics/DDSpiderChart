//
//  DDSpiderChartView.swift
//  DDSpiderChart
//
//  Created by dadalar on 05/01/2017.
//  Copyright (c) 2017 dadalar. All rights reserved.
//

import UIKit

open class DDSpiderChartView: UIView {
    
    public var axes: [DrawableString] = [] {
        didSet {
            // When categories change, data sets should be cleaned
            views.forEach { $0.removeFromSuperview() }
            views = []
        }
    }
    
    var views: [DDSpiderChartDataSetView] = [] // DDSpiderChartDataSetView's currently being presented
    
    public var color: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var circleCount: Int = 10 {
        didSet {
            views.forEach {
                $0.radius = circleRadius
                $0.setNeedsDisplay()
            }
        }
    }
    
    public var circleGap: CGFloat = 10 {
        didSet {
            views.forEach {
                $0.radius = circleRadius
                $0.setNeedsDisplay()
            }
        }
    }
    
    public var labelViewSize: CGSize = CGSize(width: 80, height: 100) {
        didSet {
            setNeedsDisplay()
        }
    }

    public func addDataSet(values: [Float], color: UIColor, animated: Bool = true) -> UIView? {
        guard values.count == axes.count else { return nil }
        
        let view = DDSpiderChartDataSetView(radius: circleRadius, values: values, color: color)
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.backgroundColor = .clear
        views.append(view)
        addSubview(view)
        if animated {
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5.0, options: [], animations: {
                view.alpha = 1.0
                view.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        return view
    }
    
    public func removeDataSetView(_ view: UIView) {
        guard let index = views.firstIndex(where: { $0 === view }) else { return }
        views.remove(at: index)
        view.removeFromSuperview()
    }
}

// MARK: Drawing methods
extension DDSpiderChartView {

    override open func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        // Draw circles
        let circlesToDraw = circleCount
        for i in 1...circlesToDraw {
            if (i == circlesToDraw) {
                let radius = CGFloat(i) * circleGap
                let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
                let color = self.color
                color.set()
                circlePath.stroke()
            }
        }

        // Draw each data set
        for (index, axis) in axes.enumerated() {
            // Draw line
            let angle = CGFloat(-Float.pi / 2) - CGFloat(index) * CGFloat(2 * Float.pi) / CGFloat(axes.count)
            self.color.set()
            let linePath = UIBezierPath()
            linePath.move(to: center)
            let x = center.x + (circleRadius + circleGap) * cos(angle)
            let y = center.y + (circleRadius + circleGap) * sin(angle)
            linePath.addLine(to: CGPoint(x: x, y: y))
            linePath.stroke()
            
            var circleCenter = CGPoint(x: center.x + (circleRadius) * cos(angle), y: center.y + (circleRadius) * sin(angle))

            circleCenter = CGPoint(x: center.x + (circleRadius + circleGap * 3/2) * cos(angle), y: center.y + (circleRadius + circleGap * 3/2) * sin(angle))
            let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleGap/2, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
            circlePath.stroke()
            
            // Draw axes label views
            let isOnTop = sin(angle) < 0 // we should draw text on top of the circle when circle is on the upper half. (and vice versa)
            let isOnLeft = cos(angle) < 0 // we should draw text on left of the circle when circle is on the left half. (and vice versa)
            let isVertical = round(abs(angle * 57.2958)).truncatingRemainder(dividingBy: 90) == 0
            let isHorizontal = round(abs(angle * 57.2958)).truncatingRemainder(dividingBy: 90) == 1
            
            let categoryStringPadding = circleGap/2
            
            var categoryStringOrigin: CGPoint?

            if isVertical {
                categoryStringOrigin = CGPoint(x: (circleCenter.x - 40), y: circleCenter.y+(isOnTop ? (-(100+categoryStringPadding)) : (categoryStringPadding)))
                if isOnLeft {
                    if isOnTop {
                        categoryStringOrigin = CGPoint(x: (circleCenter.x - 80 - categoryStringPadding), y: circleCenter.y+categoryStringPadding-50)
                    } else {
                        categoryStringOrigin = CGPoint(x: (circleCenter.x - 40), y: circleCenter.y+(isOnTop ? (-(100+categoryStringPadding)) : (categoryStringPadding)))
                    }
                } else {
                    if isOnTop {
                        categoryStringOrigin = CGPoint(x: (circleCenter.x - 40), y: circleCenter.y - (100+categoryStringPadding))
                    } else {
                        categoryStringOrigin = CGPoint(x: (circleCenter.x + categoryStringPadding), y: circleCenter.y - 50)
                    }
                }
            }

            if isOnLeft, !isVertical, !isHorizontal {
                categoryStringOrigin = CGPoint(x: circleCenter.x - 80, y: circleCenter.y+(isOnTop ? (-(100+categoryStringPadding)) : (categoryStringPadding)))
            } else if !isVertical, !isHorizontal {
                categoryStringOrigin = CGPoint(x: circleCenter.x, y: circleCenter.y+(isOnTop ? (-(100+categoryStringPadding)) : (categoryStringPadding)))
            }

            let view = UIView()
            view.frame = .init(origin: categoryStringOrigin!, size: CGSize(width: 80, height: 100))
            view.backgroundColor = .red
            addSubview(view)
        }

    }
}

// MARK: Computational properties & helper methods
extension DDSpiderChartView {
    
    fileprivate var circleRadius: CGFloat {
        return CGFloat(circleCount) * circleGap
    }
    
    override open var intrinsicContentSize: CGSize {
        let len = 2 * circleRadius + 100 // +100 for text
        return .init(width: len, height: len)
    }
        
}

