//
//  ReservationDetailsScreen.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

import SwiftUI

struct ReservationDetailsScreen: View {
    var reservation: Reservation
    
    private var formattedPrice: String {
        return String(format: "%.2f", reservation.totalPrice)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Customer Name: \(reservation.customerName)")
            Text("Passport Number: \(reservation.passportNumber)")
            Text("Departure Date: \(formattedDate)")
            Text("Flight Number: \(reservation.flightInfo.flightNumber)")
            Text("Departure Airport: \(reservation.departureAirport)")
            Text("Arrival Airport: \(reservation.arrivalAirport)")
            Text("Total Price: $\(formattedPrice)")
            Text("Booking Number: \(reservation.bookingID)")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Reservation Details")
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: reservation.departureDate)
    }
}
