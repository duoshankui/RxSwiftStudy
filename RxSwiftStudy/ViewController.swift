//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by DoubleK on 2022/8/18.
//

import UIKit

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testMethod()
    }
}


extension ViewController {
    func testMethod() {
        
        let numbers: Observable<Int> = Observable.create { observer in
            observer.onNext(1)
            return Disposables.create()
        }
        
        numbers
            .subscribe(onNext: { number in
                print(number)
            })
            .disposed(by: disposeBag)
    }
}
