//
//  MAINViewController.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-13.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit

class MAINViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var gameButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
   let customColor = UIColor(red: 0.79, green: 0.84, blue: 0.71, alpha: 1.0).cgColor
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    designButtons(buttons: [gameButton, noButton])

        // Do any additional setup after loading the view.
    }
    
    func designButtons(buttons: [UIButton]) {
        for button in buttons {
            button.layer.borderWidth = 2
            button.layer.borderColor = customColor
            button.layer.cornerRadius = gameButton.frame.height / 2
        }
    }
    @IBAction func gameButtonAction(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let ViewController = storyboard.instantiateViewController(withIdentifier: "GamingController")
//        present(ViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
