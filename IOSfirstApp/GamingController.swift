//
//  GamingController.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-13.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit

class GamingController: UIViewController {
    
   
    
    @IBOutlet weak var gameSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(gameSlider.value)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func button7Action(_ sender: UIButton) {
        switch sender.tag {
            case 7:
                navigatetoNextScreen()
            default:
                showAlert()
        }
    }
    
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Sorry, You Lost", message: "Please Try Again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

    }
    
    func navigatetoNextScreen()
    {
        let range = 7...
        
        if range.contains(Int(gameSlider.value))
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ViewController = storyboard.instantiateViewController(withIdentifier: "WowViewController")
            present(ViewController, animated: true, completion: nil)
        }
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
