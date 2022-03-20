//
//  GenericErrorMapper.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import Foundation

protocol GenericErrorMapper {
    
    associatedtype GenericError
    
    var createRequestError: GenericError { get }
    var parseError: GenericError { get }
    
    func map(error: NSError) -> GenericError
    func checkIfValidResponse(urlResponse: URLResponse?, data: Data?) -> GenericError?
}
