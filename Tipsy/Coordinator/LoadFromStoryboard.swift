//
//  LoadFromStoryboard.swift
//  Tipsy
//
//  Created by Admin on 16.09.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

protocol LoadFromStoryboard {
    static func instantiate() -> Self
}

extension LoadFromStoryboard where Self: UIViewController {
    
    /// This method creates an instance of the view controller by locating its corresponding storyboard ID, which is assumed to be the same as the class name. It then returns the instantiated view controller.
    /// - Returns: The method returns an instance of the UIViewController subclass, which is the conforming type.
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
