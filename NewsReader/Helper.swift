//
//  Helper.swift
//  NewsReader
//
//  Created by Gege on 14/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
