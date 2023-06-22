//
//  FlightReservationForm.swift
//  KRUPA_FLIGHTS
//
//  Created by Sam 77 on 2023-06-13.
//

import SwiftUI

struct FlightReservationForm: View {
    @State private var selectedArrivalAirport: String?
    @State private var departureDate = Date()
    @State private var customerName = ""
    @State private var passportNumber = ""
    @State private var flightInfo: FlightInfo?
    @State private var errorMessage: ErrorAlert?
    @State private var isReservationConfirmed = false
    @State private var shouldShowHistory = false

    private let arrivalAirports = ["MAD", "AUS", "HKG"]

    private let flightInfoMap: [String: FlightInfo] = [
        "MAD": FlightInfo(flightNumber: "AM3116", carrier: "Aeromexico", distance: 6943.70),
        "AUS": FlightInfo(flightNumber: "WS6463", carrier: "Westjet", distance: 1514.00),
        "HKG": FlightInfo(flightNumber: "KL662", carrier: "KLM", distance: 12538.51)
    ]

    private var totalPrice: Double {
            if let arrivalAirport = selectedArrivalAirport, let info = flightInfoMap[arrivalAirport] {
                let totalPrice = 100 + (info.distance * 0.12)
                return totalPrice
            }
            return 0.00
        }
    
    private var totalPriceFormatted: String {
        return String(format: "%.2f", totalPrice)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image("flight-image") // Replace "flight-image" with the name of your image asset
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)

            Text("Air Flights")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Picker("Arrival Airport", selection: $selectedArrivalAirport) {
                ForEach(arrivalAirports, id: \.self) { airport in
                    Text(airport).tag(airport as String?)
                }
            }
            .pickerStyle(.segmented)

            DatePicker("Departure Date", selection: $departureDate, in: Date()..., displayedComponents: .date)

            TextField("Customer Name", text: $customerName)

            TextField("Passport Number", text: $passportNumber)

            Button(action: confirmReservation) {
                Text("Confirm Reservation")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            if let arrivalAirport = selectedArrivalAirport {
                if let info = flightInfoMap[arrivalAirport] {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Flight: \(info.flightNumber)")
                            .font(.headline)
                        Text("Operated By: \(info.carrier)")
                        Text("Price: $\(totalPriceFormatted)")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                }
            }

            if isReservationConfirmed {
                Text("Reservation confirmed!")
                    .font(.headline)
                    .foregroundColor(.green)

                NavigationLink(
                    destination: ReservationHistoryScreen(),
                    isActive: $shouldShowHistory
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .padding()
        .alert(item: $errorMessage) { errorAlert in
            Alert(
                title: Text("Error"),
                message: Text(errorAlert.message),
                dismissButton: .default(Text("OK")) {
                    errorMessage = nil
                }
            )
        }
    }

    private func confirmReservation() {
        var errorMessages: [String] = []

        if selectedArrivalAirport == nil {
            errorMessages.append("Please select an arrival airport.")
        }

        if customerName.isEmpty {
            errorMessages.append("Please enter the customer name.")
        }

        if passportNumber.isEmpty {
            errorMessages.append("Please enter the passport number.")
        }

        if errorMessages.isEmpty {
            guard let arrivalAirport = selectedArrivalAirport, let info = flightInfoMap[arrivalAirport] else {
                errorMessage = ErrorAlert(message: "An unexpected error occurred.")
                return
            }

            flightInfo = info

            let bookingID = generateUniqueBookingID()
            
            let reservation = Reservation(
                customerName: customerName,
                passportNumber: passportNumber,
                departureDate: departureDate,
                flightInfo: info,
                departureAirport: "ATL",
                arrivalAirport: arrivalAirport,
                totalPrice: totalPrice,
                bookingID: bookingID
            )

            ReservationManager.shared.addReservation(reservation)

            isReservationConfirmed = true
            shouldShowHistory = true

            resetFormFields()
        } else {
            errorMessage = ErrorAlert(message: errorMessages.joined(separator: "\n"))
        }
    }

    private func generateUniqueBookingID() -> String {
        var bookingID = ""
        repeat {
            // Generate a random UUID
            let uuid = UUID().uuidString
            // Extract the first 5 characters from the UUID
            bookingID = String(uuid.prefix(5))
        } while ReservationManager.shared.reservations.contains(where: { $0.bookingID == bookingID })
        return bookingID
    }


    private func resetFormFields() {
        selectedArrivalAirport = nil
        departureDate = Date()
        customerName = ""
        passportNumber = ""
        flightInfo = nil
    }
}
