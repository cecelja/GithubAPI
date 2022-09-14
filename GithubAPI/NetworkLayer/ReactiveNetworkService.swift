//
//  ReactiveNetworkService.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/14/22.
//

import Foundation
import RxSwift
/**
    *Everything in RxSwift is a observable sequence
    *Arrays, Strings and Dicitionaries will be converted to observable sequences (anything that conforms to the sequence protocol)
    *Observable sequences can emit one or more events in ther life times
    *Events are Enums of type: next(), error or completed()
 **/

/**
Subjects are special forms of an Observable Sequence to which you can subscribe and add elements to it.
Example of PublishSubject: If you subscribe to it you will get all the events that will happen after you subscribed
 */

class ReactiveClass {
    let bag = DisposeBag()
    
    func reactiveFunc() {
        let helloSequence = Observable.of("Hello Rx")
        let subscription = helloSequence.subscribe(onNext: {
            print($0)
        })
        subscription.disposed(by: bag)
        var publishSubject = PublishSubject<String>()
        //You can add values to a subject with onNext()
        publishSubject.onNext("Hello")
        publishSubject.onNext("Reactive")
    }
    
}
