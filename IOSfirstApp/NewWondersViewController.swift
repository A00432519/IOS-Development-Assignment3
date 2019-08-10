//
//  NewWondersViewController.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-20.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit

class NewWondersViewController: UIViewController {

    var wonders: [Wonders] = []
    var dataToSave = Data()
    
    //local storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Wonders")
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         loadJsonFile()
        // Do any additional setup after loading the view.
        var nib = UINib(nibName: "customCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedWondersSegue" {
            let savedWondersViewController = segue.destination as? SavedWondersViewController
            savedWondersViewController?.savedWonders = loadSavedData()
        }
    }
    func loadJsonFile() {
        guard let jsonFile = Bundle.main.path(forResource: "wonders", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL (fileURLWithPath: jsonFile))
        guard let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String : Any],
            let wondersDictionary = dictionary["features"] as? [[ String : Any]]
            else { return}
        let validWonders = wondersDictionary.compactMap { Wonders (wonder: $0) }
        wonders.append(contentsOf: validWonders)
        if wonders.count > 1 {
            saveToLocalStorage()
        }
    }
    // Local storage using NSKeyedArchive
    func saveToLocalStorage() {
        do {
            dataToSave = try NSKeyedArchiver.archivedData(withRootObject: wonders, requiringSecureCoding: false)
            try dataToSave.write(to: NewWondersViewController.ArchiveURL)
        } catch {
            print("Could not write")
        }
    }
    func loadSavedData() -> [Wonders] {
        var savedWonders : [Wonders] = []
        do {
            if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataToSave) as? [Wonders] {
                savedWonders = loadedStrings
            }
        } catch {
            print("Could not read")
        }
        return savedWonders
    }
}

extension NewWondersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return wonders.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "Wonder") as? WondersTableViewCell else { return UITableViewCell()}
        cell.newWondersLabel.text = wonders[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "wow", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier: "WondersDetailsViewController") as? WondersDetailsViewController
        ViewController?.wondersDetail = [wonders[indexPath.row]]
        //present(ViewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(ViewController!, animated: true)
    }
}
