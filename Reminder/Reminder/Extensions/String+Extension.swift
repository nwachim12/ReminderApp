//
//  String+Extension.swift
//  Reminder
//
//  Created by Michael Nwachi on 7/30/24.
//

import Foundation

extension String{
    var isEmptyOrWhiteSpace: Bool{
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
