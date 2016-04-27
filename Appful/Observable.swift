//
//  Observable.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

class Observable<A> {
    var success: A? {
        didSet{ process() }
    }
    var error: ErrorType? {
        didSet{ process() }
    }
    
    var complete: Bool? {
        didSet{ process() }
    }
    
    private typealias SuccessHandler = A -> Void
    private typealias ErrorHandler = ErrorType -> Void
    private typealias CompletionHandler = () -> Void
    
    private var successHandler: SuccessHandler?
    private var errorHandler: ErrorHandler?
    private var completionHandler: CompletionHandler?
    
    init(success: A, error: ErrorType){
        self.success = success
        self.error = error
    }
    
    init(){}
    
    private func process(){
        if let value = self.success, let handler = successHandler {
            handler(value)
        } else if let err = self.error, let handler = errorHandler {
            handler(err)
        }
        if let _ = complete, let handler = completionHandler {
            handler()
        }
    }
    
    // API
    
    func onSuccess(handler: A -> Void) -> Observable<A>{
        successHandler = handler
        return self
    }
    
    func onError(handler: ErrorType -> Void) -> Observable<A>{
        errorHandler = handler
        return self
    }
    
    func onComplete(handler: () -> Void){
        completionHandler = handler
    }
    
    
    static func create(unit: Observable<A> -> ()) -> Observable<A> {
        let observable = Observable<A>()
        unit(observable)
        return observable
    }
}