//
//  ViewController.swift
//  EzParseandCoreData
//
//  Created by MacMiniCorei5-26Ghz on 6/18/18.
//  Copyright © 2018 GVN. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var groups : Groups!
    var context = NSManagedObjectContext()
    @IBOutlet weak var worldCupTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        worldCupTable.dataSource = nil
        let apiService = APIService()
        apiService.getData { (groups) in
            self.groups = groups
            DispatchQueue.main.async {
                self.worldCupTable.dataSource = self
                self.worldCupTable.reloadData()
                self.saveToCoreData()
                self.fetchFromCoreData()
            }
        }
        
    }
    
    func saveToCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
        deleteOldData()
        let worldCup = NSEntityDescription.entity(forEntityName: "WorldCup", in: context)
        for group in groups.groups {
            for team in group.teamsGroup {
                let currentTeam = NSManagedObject(entity: worldCup!, insertInto: context)
                currentTeam.setValue(group.title, forKey: "group")
                currentTeam.setValue(Int32(team.id), forKey: "id")
                currentTeam.setValue(team.teamName, forKey: "team_Name")
                currentTeam.setValue(Int32(team.winner), forKey: "winner")
                currentTeam.setValue(Int32(team.drawn), forKey: "drawn")
                currentTeam.setValue(Int32(team.lost), forKey: "lost")
                currentTeam.setValue(team.flag.description, forKey: "flag")
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Failed Saving! \(error)")
                }
            }
        }
        
    }
    
    func fetchFromCoreData() {
        let worldCupFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorldCup")
        let worldCup = try! context.fetch(worldCupFetch) as! [NSManagedObject]
        for team in worldCup {
            print("\(team.value(forKey: "group") ?? "No group")"
                + " \(team.value(forKey: "team_Name") ?? "No team")")
        }
    }
    
    func deleteOldData() {
        let worldCupFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WorldCup")
        let worldCup = try! context.fetch(worldCupFetch) as! [NSManagedObject]
        for team in worldCup {
            context.delete(team)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.groups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups.groups[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.groups[0].teamsGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = worldCupTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let team = groups.groups[indexPath.section].teamsGroup[indexPath.row]
        cell.idLabel.text = team.id.description
        cell.teamLabel.text = team.teamName
        cell.winnerLabel.text = team.winner.description
        cell.lostLabel.text = team.lost.description
        cell.drawnLabel.text = team.drawn.description
        cell.flagImageView.image = try! UIImage(data: Data(contentsOf: team.flag))
        return cell
    }
}
