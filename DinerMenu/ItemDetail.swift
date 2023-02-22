//
//  ItemDetail.swift
//  DinerMenu
//
//  Created by Ilya Tovstokory on 20.02.2023.
//

import SwiftUI

struct ItemDetail: View {
    let item: MenuItem
    
    @EnvironmentObject var order: Order
    @Environment(\.dismiss) var dismiss
    
    @State private var showOrderAlert = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            
            Button("Order This") {
                
                
                showOrderAlert.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Add to order?", isPresented: $showOrderAlert) {
            Button("OK") {
                order.add(item: item)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("The current order total would be \((order.total + item.price).formatted(.currency(code: "USD")))")
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}
