//
//  HealthKitManager.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/11/03.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import Foundation
import HealthKit

struct HealthKitManager: HealthKitManagerType {
    fileprivate let healthStore = HKHealthStore()
    fileprivate let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    /// HealthKit 값 가져오는 함수
    func findHealthKitValue(startDate: Date, endDate: Date, quantityFor: HKUnit, quantityTypeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (Double) -> Void) {
        if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate, options: .strictStartDate)
            let interval: NSDateComponents = NSDateComponents()
            interval.day = 1
            
            let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                    quantitySamplePredicate: predicate,
                                                    options: [.cumulativeSum],
                                                    anchorDate: startDate as Date,
                                                    intervalComponents: interval as DateComponents)
            
            query.initialResultsHandler = { query, results, error in
                if error != nil {
                    print("retrieveHealthKitValue error: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let results = results {
                    if results.statistics().count == 0 {
                        completion(0.0)
                    } else {
                        results.enumerateStatistics(from: startDate as Date, to: endDate as Date) {
                            statistics, stop in
                            if let quantity = statistics.sumQuantity() {
                                let quantityValue = quantity.doubleValue(for: quantityFor)
                                completion(quantityValue)
                            }
                        }
                    }
                } else {
                    print("Could not recognize HKStatisticsCollectionQuery results \(String(describing: results))!")
                }
            }
            healthStore.execute(query)
        }
    }
}
