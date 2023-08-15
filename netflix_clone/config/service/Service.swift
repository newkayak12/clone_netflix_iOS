//
//  Service.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/06/27.
//

import Foundation
import RxSwift
import Alamofire


class Service {
    private let af: Session
    private var baseUrl: String = "http://localhost:8000"
    
    public static let shared = {
        return Service()
    }()
    
    private init () {
        af = AF
    }
    
    public func setBaseUrl( baseUrl: String ) {
        self.baseUrl = baseUrl
    }
    
    private func prepareHeader () -> HTTPHeaders {
        var result: [HTTPHeader] = Array()
        if let authorization = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue) {
                result.append(HTTPHeader(name: "Authorization", value: authorization))
        }
        return HTTPHeaders(result)
    }
    
    public func get <R: Decodable>( path: Api, params: [String: Any]?, type: R.Type ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response =  af.request( baseUrl + path.rawValue, method: .get, parameters: params, headers: self.prepareHeader())
                             .responseDecodable(of: R.self) { response in
                                 switch response.result {
                                     case .success(let response):
                                         ob.onNext(response)
                                     case .failure(let error):
                                         ob.onError(error)
                                 }
                             }
                            
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    public func patch <R: Decodable>( path: Api, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path.rawValue, method: .patch, parameters: params, headers: self.prepareHeader())
                .responseDecodable(of: R.self) { response in
                    switch response.result {
                        case .success(let response):
                            ob.onNext(response)
                        case .failure(let error):
                            ob.onError(error)
                    }
                }
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    public func post <R: Decodable>( path: Api, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path.rawValue, method: .post, parameters: params, headers: self.prepareHeader())
                .responseDecodable(of: R.self) { response in
                    switch response.result {
                        case .success(let response):
                            ob.onNext(response)
                        case .failure(let error):
                            ob.onError(error)
                    }
                }
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    public func delete <R: Decodable>( path: Api, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path.rawValue, method: .delete, parameters: params, headers: self.prepareHeader())
                .responseDecodable(of: R.self) { response in
                    switch response.result {
                        case .success(let response):
                            ob.onNext(response)
                        case .failure(let error):
                            ob.onError(error)
                    }
                }
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
}


enum Api: String {
    case USER_SIGN_IN = ""
}
