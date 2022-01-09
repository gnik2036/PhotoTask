//
//  Monitor.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 09/01/2022.

import Network

class Monitor {
    private let monitor: NWPathMonitor =  NWPathMonitor()

    init() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}

extension Monitor {
    func startMonitoring(callBack: @escaping (_ isReachable: Bool) -> Void ) -> Void {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { callBack(path.status == .satisfied) }
        }
    }
    
    func cancel() {
        monitor.cancel()
    }
}
