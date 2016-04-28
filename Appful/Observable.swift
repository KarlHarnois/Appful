//
//  Observable.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

public class Observable<A> {
    private var success: A? {
        didSet{ process() }
    }
    private var error: ErrorType? {
        didSet{ process() }
    }
    
    private var completionFlag: Bool? {
        didSet{ process() }
    }
    
    private typealias SuccessHandler = A -> Void
    private typealias ErrorHandler = ErrorType -> Void
    private typealias CompletionHandler = () -> Void
    
    private var successHandler: SuccessHandler?
    private var errorHandler: ErrorHandler?
    private var completionHandler: CompletionHandler?
    
    private func process(){
        if let value = self.success, let handler = successHandler {
            handler(value)
        }
        if let err = self.error, let handler = errorHandler {
            handler(err)
        }
        if let _ = completionFlag, let handler = completionHandler {
            handler()
        }
    }
    
    //
    // Constructors
    //
    
    init(success: A, error: ErrorType){
        self.success = success
        self.error = error
    }
    
    init(){}
    
    static func create(unit: Observable<A> -> ()) -> Observable<A> {
        let observable = Observable<A>()
        unit(observable)
        return observable
    }
    
    //
    // Subscription API
    // 
    
    public func onStart(setup: () -> Void) -> Observable<A> {
        setup()
        return self
    }
    
    public func onSuccess(handler: A -> Void) -> Observable<A>{
        successHandler = handler
        return self
    }
    
    public func onError(handler: ErrorType -> Void) -> Observable<A>{
        errorHandler = handler
        return self
    }
    
    public func onComplete(handler: () -> Void){
        completionHandler = handler
    }
    
    //
    // Setters API
    //
    
    func success(value: A){
        self.success = value
    }
    
    func error(value: ErrorType){
        self.error = value
    }
    
    func complete(){
        self.completionFlag = true
    }
}



