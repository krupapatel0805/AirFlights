//
//  ContentView.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var reservationManager: ReservationManager

    var body: some View {
        TabView {
            FlightReservationForm()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Reservation")
                }
            
            ReservationHistoryScreen()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
                .environmentObject(reservationManager) // Add this line to pass the reservationManager to ReservationHistoryScreen
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ReservationManager()) // Add this line to provide a ReservationManager instance
    }
}
