//
//  APIError.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import Foundation

enum APIError: Error {
    
    // 400s
    case badRequest(body: Any?)
    case unauthorized(body: Any?)
    case notFound(body: Any?)
    case conflict(body: Any?)
    case gone(body: Any?)
    case unsupportedMediaType(body: Any?)
    
    // 500s
    case internalServerError(body: Any?)
    case serviceUnavailable
    
    // Other
    case emptyResponse
    case notHTTPURLResponse
    case failedToParseResponse
    case failedCreatingRequest
    case cancelled
    case invalidPostcode(json: [[String:Any]]?)

    // Catch all
    case unknown
}

class APIErrorMapper: GenericErrorMapper {
    
    typealias GenericError = APIError
    
    let parseError: APIError = .failedToParseResponse
    let createRequestError: APIError = .failedCreatingRequest
    
    func map(error: NSError) -> GenericError {
        
        AppConstant().log(message:"AAErrors \n\n\n\n\n\n\n")
        AppConstant().log(message:"AAError Code:\(error.code)")
        AppConstant().log(message:"AAError description:\(error.description)")
        AppConstant().log(message:"Error debugDescription:\(error.debugDescription)")
        AppConstant().log(message:"Error localizedDescription:\(error.localizedDescription)")
        AppConstant().log(message:"Error localizedFailureReason:\(String(describing: error.localizedFailureReason))")

        AppConstant().log(message:"AAErrors \n\n\n\n\n\n\n")

        switch error.code {
        case 401:
            return .unauthorized(body: nil)
            
        case -999:
            return .cancelled
            
        default:
            return .unknown
        }
    }
    
    func checkIfValidResponse(urlResponse: URLResponse?, data: Data?) -> GenericError? {
        guard let response = urlResponse else {
            return .emptyResponse
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .notHTTPURLResponse
        }

        guard httpResponse.statusCode < 200 || httpResponse.statusCode > 299 else {
            return nil
        }
        
        let body = getRequestBody(data: data)
        
        switch httpResponse.statusCode {
        case 400:
            return .badRequest(body: body)
            
        case 401:
            return .unauthorized(body: body)
            
        case 404:
            return .notFound(body: body)
            
        case 409:
            return .conflict(body: body)
            
        case 410:
            return .gone(body: body)
            
        case 415:
            return .unsupportedMediaType(body: body)
            
        case 500:
            return .internalServerError(body: body)
            
        case 503:
            return .serviceUnavailable

        case -999:
            return .cancelled
            
        default:
            return .unknown
        }
    }
    
    private func getRequestBody(data: Data?) -> Any? {
        guard let jsonData = data else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: jsonData, options:[])
    }
    
    func isUnauthorized(error: APIError) -> Bool {
        switch error {
        case .unauthorized:
            return true
        default:
            return false
        }
    }
    
}
