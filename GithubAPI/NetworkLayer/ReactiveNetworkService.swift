////
////  ReactiveNetworkService.swift
////  GithubAPI
////
////  Created by Filip Cecelja on 9/14/22.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
///**
//    *Everything in RxSwift is a observable sequence
//    *Arrays, Strings and Dicitionaries will be converted to observable sequences (anything that conforms to the sequence protocol)
//    *Observable sequences can emit one or more events in ther life times
//    *Events are Enums of type: next(), error or completed()
// **/
//
///**
//Subjects are special forms of an Observable Sequence to which you can subscribe and add elements to it.
//Example of PublishSubject: If you subscribe to it you will get all the events that will happen after you subscribed
// */
//
//class ReactiveClass {
//    let bag = DisposeBag()
//
//    func reactiveFunc() {
//        let helloSequence = Observable.of("Hello Rx")
//        let subscription = helloSequence.subscribe(onNext: {
//            print($0)
//        })
//        subscription.disposed(by: bag)
//        var publishSubject = PublishSubject<String>()
//
//        let subscription1 = publishSubject.subscribe(onNext: {
//            print($0)
//        }).disposed(by: bag)
//
//        //You can add values to a subject with onNext()
//        publishSubject.onNext("Hello")
//        publishSubject.onNext("Reactive")
//
//        let subscription2 = publishSubject.subscribe(onNext: {
//            print($0)
//        }).disposed(by: bag)
//
//        publishSubject.onNext("Both Subs recieve this")
//    }
//
//    func fetch() -> Observable<Repository> {
//        let url = URL(string: "https://api.github.com/orgs/undabot/repos")!
//        let request = URLRequest(url: url)
//
//        return URLSession.shared.rx.response(request: request)
//            .map{result -> Repository in
//                guard result.response.statusCode == 200
//                else {throw RequestError.serverError} }
//
//        return result.
//
//        return
//    }
//
//}
//
///**
// Basic functions:
// sub.delay(150, scheduler: s) - delays by 150 miliseconds every event
// map() - transform the elements of a sequence somehow
// flatmap() - if we have a sequence of observables we can merge the emission of these resulting observables
// */
