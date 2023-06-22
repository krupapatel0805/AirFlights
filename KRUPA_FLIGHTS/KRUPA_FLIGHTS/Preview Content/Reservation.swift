//
//  Reservation.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

import SwiftUI

class ReservationManager: ObservableObject {
    static let shared = ReservationManager()
    
    @Published var reservations: [Reservation] = []
    
    func addReservation(_ reservation: Reservation) {
        reservations.append(reservation)
    }
    
    func deleteReservation(_ reservation: Reservation) {
        if let index = reservations.firstIndex(where: { $0.bookingID == reservation.bookingID }) {
            reservations.remove(at: index)
        }
    }
}


struct Reservation: Identifiable {
    var id = UUID()
    var customerName: String
    var passportNumber: String
    var departureDate: Date
    var flightInfo: FlightInfo
    var departureAirport: String
    var arrivalAirport: String
    var totalPrice: Double
    var bookingID: String
    
    var bookingNumber: String {
        // Format the booking ID as a 5-character string
        return String(bookingID.prefix(5))
    }
}

struct FlightInfo {
    var flightNumber: String
    var carrier: String
    var distance: Double
}

struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
}
