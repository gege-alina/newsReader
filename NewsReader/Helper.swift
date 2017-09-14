//
//  Helper.swift
//  NewsReader
//
//  Created by Gege on 14/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit
class Helper {
    
    static let dateFormatter = DateFormatter()
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        Helper.dateFormatter.dateFormat = format
        return Helper.dateFormatter.string(from: self)
    }
}
