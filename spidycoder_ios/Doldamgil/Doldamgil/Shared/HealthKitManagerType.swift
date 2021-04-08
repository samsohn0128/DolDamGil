//
//  HealthKitManagerType.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/11/03.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthKitManagerType {
  func findHealthKitValue(startDate: Date, endDate: Date, quantityFor: HKUnit, quantityTypeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (_ quantityValue: Double) -> Void)
}
