//
//  BMCBLModelSubclass.swift
//  CBL Bug Demo
//
//  Created by Basit Mustafa on 22/4/15.
//  Copyright (c) 2015 Basit Mustafa. All rights reserved.
//
import FXForms

class BMCBLModelSubclass: CBLModel, FXForm {
    
    override func awakeFromInitializer() {
        super.awakeFromInitializer()
        self.autosaves = true
        
    }
    
    @NSManaged var aStringToInherit : String
    @NSManaged var aDateToInherit : NSDate
    
    
}
