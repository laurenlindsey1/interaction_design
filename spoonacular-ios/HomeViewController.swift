//
//  HomeViewController.swift
//  spoonacular
//
//  Created by Lauren Lindsey on 10/23/19.
//  Copyright © 2019 Dondi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var slider1: Slider!
//    let rangeSlider = Slider(frame: CGRect.zero)

    
    @IBOutlet weak var SearchRecipes: UIButton!
    
    @IBOutlet weak var SearchIngredients: UIButton!
    
    @IBOutlet weak var SearchVideos: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchRecipes.layer.cornerRadius = 45
        SearchIngredients.layer.cornerRadius = 45
        SearchVideos.layer.cornerRadius = 45
        
//        view.addSubview(rangeSlider)
        slider1.addTarget(self, action: "rangeSliderValueChanged:", for: .valueChanged)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func rangeSliderValueChanged(_ sender: Any) {
        if(slider1.upperValue * 10 > 5) {
            let time = Double(10.1 - slider1.upperValue * 10)

            self.view.backgroundColor = UIColor.blue


            UIView.animate(withDuration: time, delay: 0, options: [.autoreverse, .allowUserInteraction, .repeat], animations: {
                    self.view.backgroundColor = UIColor.white
                }, completion: nil)
        }
    }
    
    
}
