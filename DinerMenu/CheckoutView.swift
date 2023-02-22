//
//  CheckoutView.swift
//  DinerMenu
//
//  Created by Ilya Tovstokory on 21.02.2023.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    
    let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 15
    
    @State private var showingPaymentAlert = false
    
    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return(total + tipValue).formatted(.currency(code: "USD"))
    }
    
     let paymentTypes = ["Cash", "Credit Card", "Diner Points"]
    
    var body: some View {
            Form {
                Section {
                    Picker("How do you want to pay?", selection: $paymentType) {
                        ForEach(paymentTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Toggle("Add Diner loyalty card", isOn: $addLoyaltyDetails.animation())
                    
                    if addLoyaltyDetails {
                        TextField("Enter your Diner ID", text: $loyaltyNumber)
                    }
                }
                
                Section("Add a tip?") {
                    Picker("Percentage: ", selection: $tipAmount) {
                        ForEach(tipAmounts, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total: \(totalPrice)") {
                    Button("Confirm Order") {
                        showingPaymentAlert.toggle()
                    }
                }
            }
            
            .navigationTitle("Payment")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Order confirmed", isPresented: $showingPaymentAlert) {
                Button("OK") {
                    order.items.removeAll()
                    dismiss()
                }
            } message: {
                Text("Your total was \(totalPrice) – thank you!")
            }
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
