//
//  SliderTrackLayer.swift
//  sliderTest
//
//  Created by Lauren Lindsey on 12/13/19.
//  Copyright © 2019 Lauren Lindsey. All rights reserved.
//

import UIKit
import QuartzCore


class SliderTrackLayer: CALayer {

    weak var slider: Slider?


    override func draw(in ctx: CGContext) {
        if let slider = slider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)

            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()

            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = CGFloat(slider.minimumValue)

            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            ctx.fill(rect)
        }
    }

}
