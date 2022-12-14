//
//  AboutViewController.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/14/22.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutTf: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        aboutTf.text = "\"I Can Refer\" project is created keeping in mind the current situation caused by COVID19 pandemic. Many people have lost their jobs and are struggling to find new ones during the pandemic. Also, some people have come forward to support and help others by providing referrals for their current organization's available positions.\n\nThe application provides a consolidated platform for the users to post details about referral or any professional help they can provide. The post can have details such as organization's name, available positions with required skills, contact details, etc.\n\nUsers can view all the available posts and contact the concerned person via given details. Also, users can log into the application and open the dashboard to manage i.e. view, create, update & delete their posts."
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
