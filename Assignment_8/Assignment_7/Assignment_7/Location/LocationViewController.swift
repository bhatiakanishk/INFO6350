//
//  LocationViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/4/22.
//

import UIKit

class LocationViewController: UIViewController {
    var mainVC: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCreateTap(_ sender: Any) {
        let vc = CreateLocationViewController(nibName: "CreateLocationView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnViewTap(_ sender: Any) {
        let vc = ViewLocationViewController(nibName: "ViewLocationView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnUpdateTap(_ sender: Any) {
        let vc = UpdateLocationViewController(nibName: "UpdateLocationView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteTap(_ sender: Any) {
        let vc = DeleteLocationViewController(nibName: "DeleteLocationView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
