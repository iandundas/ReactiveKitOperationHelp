//
//  AppDelegate.swift
//  FlatmapExample
//
//  Created by Ian Dundas on 16/03/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var disposable: DisposableType! // just in case
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        func successOperation() -> Operation<String, NSError>{
            return Operation{observer in
                observer.success()
                return SimpleDisposable()
            }
        }
        
        let a = ActiveStream<String>()
        let b = a.flatMap(OperationFlatMapStrategy.Latest) { whatever -> Operation<String, NSError> in
            return successOperation()
        }
        
        disposable = b.observe { event in
            switch event{
            case .Success:
                print("success")
                
            default:
                print("anything else")
            }
        }
        
        a.next("sending something")
        
        return true
    }

}

