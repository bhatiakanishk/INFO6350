//
//  ItemViewController.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/4/22.
//

import UIKit

class ItemViewController: UIViewController {
    
    var mainVC: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func createItemTap(_ sender: Any) {
        let vc = CreateItemViewController(nibName: "CreateItemView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func updateItemTap(_ sender: Any) {
        let vc = UpdateItemViewController(nibName: "UpdateItemView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewItemTap(_ sender: Any) {
        let vc = ViewItemViewController(nibName: "ViewItemView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteItemTap(_ sender: Any) {
        let vc = DeleteItemViewController(nibName: "DeleteItemView", bundle: nil)
        vc.mainVC = mainVC
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
