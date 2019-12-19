//
//  MainMenuViewController.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit

class MainMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var mainMenuView: UITableView!
    
    let dispatchGroup = DispatchGroup()
    
    var refreshControl = UIRefreshControl()
    
    var categories = [MenuCategory]()
    
    let networkManager = NetworkManager()
    
    let databaseManager = DatabaseManager()
    
    var alert: UIAlertController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainMenuView.dataSource = self
        
        if(databaseManager.mainMenuCategoriesRequiresSaving())
        {
            databaseManager.saveMainMenuCategories()
        }
        else
        {
            categories = databaseManager.retrieveMainMenuCategories()
        }
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *)
        {
            mainMenuView.refreshControl = refreshControl
        }
        else
        {
            mainMenuView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing database tables...")
    }
        
    @objc private func refreshTableData(_ sender: Any)
    {
        self.refreshTableData()
    }
        
    func refreshTableData()
    {
//            dispatchGroup.enter()
//
//            networkManager.updateGameLogs()
//            networkManager.saveRosters()
//            networkManager.saveStandings()
//            networkManager.updateSchedule()
//
//            dispatchGroup.leave()
//
//            dispatchGroup.notify(queue: .main)
//            {
//                print("Notified....")
//
            self.refreshControl.endRefreshing()
//                self.linkTables()
//
//                print("Complete....")
//            }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let backgroundImage = UIImage(named: "HockeyBackground")
        
        let imageView = UIImageView(image: backgroundImage)
        imageView.alpha = 0.1

        mainMenuView.backgroundView = imageView
        mainMenuView.separatorStyle = .none

        // Center and scale background image
        mainMenuView.contentMode = .scaleAspectFit
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        switch(indexPath.row)
        {
            case 0: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "scheduleCategory2")!, newWidth: CGFloat(50))
            case 1: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "teamInformationCategory")!, newWidth: CGFloat(50))
            case 2: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "searchPlayersCategory")!, newWidth: CGFloat(50))
            case 3: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "NHL")!, newWidth: CGFloat(50))
            case 4: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "scoreCategory")!, newWidth: CGFloat(50))
            default: cell?.imageView?.image = ConversionUtils.resizeImage(image: UIImage(named: "settingsCategory")!, newWidth: CGFloat(50))
        }
        
        cell?.textLabel?.text = categories[indexPath.row].category

        cell?.accessoryType = .disclosureIndicator

        cell!.backgroundColor = UIColor.clear

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        if(databaseManager.teamTableRequiresLinking())
//        {
//            linkTables()
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)

        let category = categories[indexPath.row].category

        if(category == "Season Schedule")
        {
            databaseManager.retrieveTodaysGames()
        }
//        else if(category == "Scores")
//        {
//            networkManager.updateScheduleForDate(Date())
//
//            databaseManager.displaySchedule(self, "displayScores")
//        }
//        else if(category == "Team Information")
//        {
//            databaseManager.displayTeams(self, category)
//        }
//        else if(category == "Standings")
//        {
//            databaseManager.displayStandings(self)
//        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?)
    {
        //withIdentifier: "displayPlayer", sender: playerResult
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "displaySchedule")
        {
            let displayCalendarViewController = segue.destination as! DisplayCalendarViewController

            displayCalendarViewController.scheduledGames = sender as! [NHLSchedule]
        }
//        else if(segue.identifier == "displayAllTeams")
//        {
//            let displayTeamsViewController = segue.destination as! DisplayTeamsViewController
//
//            displayTeamsViewController.segueId = segue.identifier!
//
//            displayTeamsViewController.teamResults = sender as? Results<NHLTeam>
//        }
//        else if(segue.identifier == "displayScores")
//        {
//            let displayScoresViewController = segue.destination as! DisplayScoresViewController
//
//            displayScoresViewController.nhlSchedules = sender as? Results<NHLSchedule>
//        }
//        else if(segue.identifier == "displayStandings")
//        {
//            let displayStandingsTabViewController = segue.destination as! DisplayStandingsTabViewController
//
//            displayStandingsTabViewController.teamStandingsResults = sender as? Results<TeamStandings>
//        }
    }
}

extension MainMenuViewController: NetworkManagerDelegate
{
    func didPerformNetworkCall<T>(_ obj: T)
    {
        if obj is [NHLSchedule]
        {
            
        }
        else if obj is [NHLPlayer]
        {
            
        }
        else if obj is [NHLTeam]
        {
            
        }
        else if obj is [TeamStandings]
        {
            
        }
        
    }
    
    func didFailWithError(error: Error)
    {
        print(error.localizedDescription)
        fatalError(error.localizedDescription)
    }
}
