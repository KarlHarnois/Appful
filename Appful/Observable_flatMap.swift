//
//  Observable_flatMap.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

extension Observable {
    func flatMap<B>(f: A -> Observable<B>) -> Observable<B>{
        return Observable<B>.create{ observer in
            return self
                .onSuccess{ (x: A) in
                    let observable: Observable<B> = f(x)
                    observable
                        .onSuccess{ (y: B) in
                            observer.success = y
                        }
                        .onError{ error in
                            observer.error = error
                        }
                        .onComplete{
                            observer.complete = true
                    }
                }
                .onError{ error in
                    observer.error = error
                }
                .onComplete{
            }
        }
    }
}