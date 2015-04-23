//
//  MasterViewController.swift
//  CBL Bug Demo
//
//  Created by Basit Mustafa on 22/4/15.
//  Copyright (c) 2015 Basit Mustafa. All rights reserved.
//

import UIKit
import FXForms

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
      var appDelegate : AppDelegate?

    @IBOutlet var dataSource: CBLUITableSource!

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let mainApplication = UIApplication.sharedApplication()
        
        if let delegate = mainApplication.delegate as? AppDelegate {
            self.appDelegate = delegate;
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        
        // Create a query sorted by descending date, i.e. newest items first:
        let query = self.appDelegate?.cblDatabase!.viewNamed("arbitraryObjects").createQuery().asLiveQuery()
        
        query!.descending = true
        
        
        // Plug the query into the CBLUITableSource, which will use it to drive the table view.
        // (The CBLUITableSource uses KVO to observe the query's .rows property.)
        
        self.dataSource = CBLUITableSource()
        self.dataSource.tableView = self.tableView
        self.tableView.dataSource = self.dataSource
        
        self.dataSource.query = query!
        self.dataSource.labelProperty = "aDateToInherit"    // Document property to display in the cell label
        
        self.title = "Aribtrary Objects"
        self.tableView.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        // Create New Object
        let db = self.appDelegate?.cblDatabase!
        let newCase = BMArbitraryObject(forNewDocumentInDatabase: db!)
     
        newCase.anArbitraryString = "So Random"
        newCase.aDateToInherit =  NSDate()
        newCase.anAribtraryNSNumber = 42 // Duh, of course.
       
        
        var error: NSError?
        
        if !newCase.save(&error) {
            println(error)
        }
        
        
    }

    func couchTableSource(
        source: CBLUITableSource!,
        willUseCell cell: UITableViewCell!,
        forRow row: CBLQueryRow!)
    {
        // Set the cell background and font:
        //    cell.backgroundColor = kBGColor
        //    cell.selectionStyle = .Gray
        
        cell.textLabel!.font = UIFont(name: "Helvetica", size: 18.0)
        cell.textLabel!.backgroundColor = UIColor.clearColor()
        //  let rowValue = row.value as? VTCase
        // Configure the cell contents. Our view's map function (above) copies the document properties
        // into its value, so we can read them from there without having to load the document.
        
        
        // cell.textLabel.text is already set, thanks to setting up labelProperty above.
        
        // cell.detailTextLabel!.text = "Some detial text!"
    }
    
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.dataSource.rowAtIndexPath(indexPath)?.document
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = CBLModel(forDocument: object!) as? BMArbitraryObject
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //   self.performSegueWithIdentifier("showDetail", sender: self)
        
        var caseVc = FXFormViewController()
        
        let object = self.dataSource.rowAtIndexPath(indexPath)?.document
        
        
        var caseObj = CBLModel(forDocument: object!) as? BMArbitraryObject
        caseVc.formController.form = caseObj
        
        caseVc.title = caseObj?.anArbitraryString
        
        self.navigationController?.pushViewController(caseVc, animated: true);
        
    }
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}

