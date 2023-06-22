//
//  KRUPA_FLIGHTSApp.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

// KRUPA_FLIGHTSApp.swift

import SwiftUI

@main
struct KRUPA_FLIGHTSApp: App {
    @StateObject private var reservationManager = ReservationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reservationManager)
        }
    }
}
