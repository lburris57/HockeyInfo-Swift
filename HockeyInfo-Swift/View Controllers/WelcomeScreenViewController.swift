//
//  ViewController.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/15/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit

class WelcomeScreenViewController: UIViewController
{
    @IBOutlet weak var HockeyInfoLabel: UILabel!
    @IBOutlet weak var poweredByLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        displayHockeyInfoScrollingText()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25)
        {
            self.displayPoweredByScrollingText()
        }
    }
    
    func displayHockeyInfoScrollingText()
    {
        HockeyInfoLabel.text = "Hockey Info"
    }
    
    func displayPoweredByScrollingText()
    {
        poweredByLabel.text = ""
        poweredByLabel.text = "Powered by My Sports Feeds"
    }
    @IBAction func mainMenuButtonTapped(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "welcomeToMain", sender: nil)
    }
}

