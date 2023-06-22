//
//  ReservationHistoryScreen.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

import SwiftUI

struct ReservationHistoryScreen: View {
    @EnvironmentObject var reservationManager: ReservationManager

    var body: some View {
        NavigationView {
            List {
                ForEach(reservationManager.reservations) { reservation in
                    NavigationLink(destination: ReservationDetailsScreen(reservation: reservation)) {
                        VStack(alignment: .leading) {
                            Text("Customer Name: \(reservation.customerName)")
                            Text("Booking ID: \(reservation.bookingID)")
                        }
                    }
                }
                .onDelete(perform: deleteReservation)
            }
            .navigationBarTitle("Reservation History")
        }
    }

    private func deleteReservation(at offsets: IndexSet) {
        let indexToRemove = offsets.first!
        let reservationToRemove = reservationManager.reservations[indexToRemove]
        reservationManager.deleteReservation(reservationToRemove)
    }
}
