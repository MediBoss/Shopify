//
//  Result.swift
//  Lofti
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

enum Result<T> {
    /**
     Defines different types of results that can be received during a networking session
     
     -Cases:
        - success(T) - returns a generic decoded data type if the session was successful
        - failure(Error) - returns an Errror object if the session has failed
     **/
    
    case success(T)
    case failure(Error)
}
