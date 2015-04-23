//
//  DetailViewController.swift
//  CBL Bug Demo
//
//  Created by Basit Mustafa on 22/4/15.
//  Copyright (c) 2015 Basit Mustafa. All rights reserved.
//

import UIKit
import FXForms

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    func configureView() {
        // Update the user interface for the detail item.
        
        self.title=""
        
        if(self.detailItem != nil)
        {
            var caseVc = FXFormViewController()
            
            caseVc.formController.form = self.detailItem as! FXForm
            
            caseVc.title = "Some Arbitrary Item"
            
            
            
            self.navigationController?.pushViewController(caseVc, animated: true);
            
        }
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

