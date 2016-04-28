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
                    f(x).onSuccess{ (y: B) in
                            observer.success(y)
                        }
                        .onError{ error in
                            observer.error(error)
                        }
                        .onComplete{
                            observer.complete()
                        }
                }
                .onError{ error in
                    observer.error(error)
                    observer.complete() // temporary solution for self.onComplete()
                }
                .onComplete{
                    /*
                     Will need to find a solution
                     else the first onComplete() will never get called
                    */
                }
        }
    }
}

