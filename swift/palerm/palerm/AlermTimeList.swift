//
//  AlermTimeList.swift
//  palerm
//
//  Created by 花城周平 on 2019/07/02.
//  Copyright © 2019 花城周平. All rights reserved.
//

import Foundation
import RxSwift

class AlermTimesStore {
    private let subject = BehaviorSubject(value: [] as [AlermTime])
    var list: Observable<[AlermTime]> { return self.subject }
    private var _value: [AlermTime] = []
    
    func set(list: [AlermTime]) {
        self._value = list
        subject.onNext(list)
    }
    
    func get() -> [AlermTime] {
        return self._value
    }
    
    func append(alermTime: AlermTime) -> Bool {
        var tmpList = self.get()
        tmpList.append(alermTime)
        self.set(list: tmpList)
        return true
    }
    
    func remove(hour: String, min: String) -> Bool {
        for (index, alermTime) in self.get().enumerated() {
            if alermTime.hour == hour, alermTime.min == min {
                var tmpList = self.get()
                tmpList.remove(at: index)
                self.set(list: tmpList)
                return true
            }
        }
        return false
    }
}
