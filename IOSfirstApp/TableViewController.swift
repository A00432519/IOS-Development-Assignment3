//
//  TableViewController.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-13.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var wondersOfTheWorld: [String] = []
    var imageNames: [String] = []
    let reuseIdentifier = String (describing: WondersTableViewCell.self)
    var wonders: [Wonders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    wondersOfTheWorld = ["Great Pyramid of Giza", "Colossus of Rhodes", "Hanging Gardens of Babylon", "Lighthouse of Alexandria", "Mausoleum at Halicarnassus", "Statue of Zeus at Olympia", "Temple of Artemis at Ephesu"]
        
        imageNames = ["pyramid", "statue", "flower", "lighthoue", "Image" ,"statue", "temple"]
        
        loadJsonFile()
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
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wondersOfTheWorld.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? WondersTableViewCell else { return UITableViewCell()}

        //var indexPathOne = IndexPath(item: 0, section: 0)

        if indexPath.item % 2 == 0{
            cell.backgroundColor = UIColor.gray
            
        } else {
            cell.backgroundColor = UIColor.darkGray
        }
         //cell.textLabel?.text = wondersOfTheWorld[indexPath.item]
        //cell.wondersLabel.text = wonders[indexPath.row].name
        cell.wondersLabel.text = wondersOfTheWorld[indexPath.row]
        cell.icon.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
