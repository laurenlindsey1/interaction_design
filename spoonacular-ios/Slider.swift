//HUGE credit goes to this tutorial:
//https://www.raywenderlich.com/2297-how-to-make-a-custom-control-tutorial-a-reusable-slider#toc-anchor-006


import UIKit
import QuartzCore

@IBDesignable class Slider: UIControl {
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.0
    var upperValue = 1.0
    let trackLayer = SliderTrackLayer()

    let sliderControl = SliderThumbLayer()
    var previousLocation = CGPoint()


    var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightTintColor = UIColor(red: 0.8, green: 0.702, blue: 1.0, alpha: 1.0)
    var thumbTintColor = UIColor.white
    var curvaceousness: CGFloat = 1.0

    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        layoutSubviews()
    }

    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear

        trackLayer.slider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        sliderControl.rangeSlider = self
        sliderControl.contentsScale = UIScreen.main.scale
        layer.addSublayer(sliderControl)

    }

    func updateLayerFrames() {


        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()

        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        sliderControl.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
            width: thumbWidth, height: thumbWidth)
        sliderControl.setNeedsDisplay()
    }

    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
        (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

        previousLocation = touch.location(in: self)

        if sliderControl.frame.contains(previousLocation) {
            sliderControl.highlighted = true
        }

        return sliderControl.highlighted
    }

    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previousLocation = location

        // 2. Update the values
        if sliderControl.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }

        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        updateLayerFrames()
        CATransaction.commit()
        sendActions(for: .valueChanged)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        sliderControl.highlighted = false
    }
}
