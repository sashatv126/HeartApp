//
//  MainWorker.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import Foundation
protocol MainWorkingLogic {
    func startPulse()
    func get(duration: Double, copmletion: @escaping((String?) -> Void))
    func getResults(completion: @escaping(([String]) -> Void))
}

final class MainWorker {
    // MARK: - Private Properties
    private var pulse: Pulse?
    private var results: [String] = []
    
    init(pulse: Pulse) {
        self.pulse = pulse
    }
}

// MARK: - Working Logic
extension MainWorker: MainWorkingLogic {
    func getResults(completion: @escaping(([String]) -> Void)) {
        DispatchQueue.global(qos: .background).async { [self] in
            var arrayStrings = [String]()
            let filtered = results.filter({Int($0) != nil})
            if !filtered.isEmpty, filtered.count >= 2 {
                let arrayInt = filtered.map({Int($0)})
                let max = arrayInt.min!
                let average = arrayInt.average!
                arrayStrings.append(String(max))
                arrayStrings.append(String(average))
                completion(arrayStrings)
            }
        }
    }
    
    func startPulse() {
        pulse?.initVideoCapture()
        pulse?.initCaptureSession()
    }
    
    func get(duration: Double, copmletion: @escaping((String?) -> Void)) {
        DispatchQueue.main.async {[weak self] in
            self?.pulse?.startMeasurement(duration: duration) {[weak self] result in
                guard let result = result, let self = self else { return }
                if result != Text.wait.uppercased() {
                    self.results.append(result)
                }
                copmletion(result)
            }
        }
        
    }
}
