//
//  ContentView.swift
//  RetirmentCalculator
//
//  Created by willaim santos on 09/04/24.
//

import SwiftUI
import SwiftData
import AppCenterCrashes
import AppCenterAnalytics

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showAlert = Crashes.hasCrashedInLastSession
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                 
                    Button(action: {
//                        Crashes.generateTestCrash()
                        addItem()
                    }, label: {
                        Label("Add Item", systemImage: "plus")

                    })
                }
            }
        } detail: {
            Text("Select an item")
        }.onChange(of: showAlert) {
            Alert(title: Text("Oopss"), message: Text("Session Time Out"), dismissButton: .cancel())
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
            let timestamp = newItem.timestamp.timeIntervalSince1970
            let itemId: String = String(newItem.persistentModelID.entityName)
            
            let properties = ["timestamp": String(timestamp),
                              "ID": String(itemId)]
            Analytics.trackEvent("calculate_retirement_amount", withProperties: properties )

        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
