//
//  Synchronized.swift
//  Camira
//
//  Created by Marcus Kida on 17/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Foundation

public func synchronized (object: AnyObject, closure: ()->()) {
    objc_sync_enter(object)
    closure()
    objc_sync_exit(object)
}