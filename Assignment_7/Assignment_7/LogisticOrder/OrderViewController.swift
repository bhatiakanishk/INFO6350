//
//  OrderViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/6/22.
//

import UIKit

class OrderViewController: UIViewController {
    
    var mainVC: MainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCreateTap(_ sender: Any) {
        let vc = CreateOrderViewController(nibName: "CreateOrderView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewTap(_ sender: Any) {
        let vc = ViewOrderViewController(nibName: "ViewOrderView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnUpdateTap(_ sender: Any) {
        let vc = UpdateOrderItemViewController(nibName: "UpdateOrderItemView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnDeleteTap(_ sender: Any) {
        let vc = DeleteOrderViewController(nibName: "DeleteOrderView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnUpdateDepartureDate(_ sender: Any) {
        let vc = UpdateDepartureDateViewController(nibName: "UpdateDepartureDateView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnSearchByDate(_ sender: Any) {
        let vc = SearchByDateViewController(nibName: "SearchByDateView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnSearchByLocation(_ sender: Any) {
        let vc = SearchByLocationViewController(nibName: "SearchByLocationView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnCloseTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
