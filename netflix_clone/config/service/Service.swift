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
    private var baseUrl: String = ""
    
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
        if let authorization = UserDefaults.standard.string(forKey: "Authroization") {
                result.append(HTTPHeader(name: "Authorization", value: authorization))
        }
        return HTTPHeaders(result)
    }
    
    public func get <R: Decodable>( path: String, params: [String: Any]?, type: R.Type ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response =  af.request( baseUrl + path, method: .get, parameters: params, headers: self.prepareHeader())
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
    
    public func patch <R: Decodable>( path: String, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path, method: .patch, parameters: params, headers: self.prepareHeader())
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
    
    public func post <R: Decodable>( path: String, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path, method: .post, parameters: params, headers: self.prepareHeader())
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
    
    public func delete <R: Decodable>( path: String, params: [String: Any]? ) -> Observable<R> {
        return Observable.create { [unowned self] ob in
            let response = af.request( baseUrl + path, method: .delete, parameters: params, headers: self.prepareHeader())
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
