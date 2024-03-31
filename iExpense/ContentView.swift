//
//  ContentView.swift
//  iExpense
//
//  Created by Hina Khan on 31/03/2024.
//

import SwiftUI
import Combine


class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}



struct ContentView: View {
    @StateObject private var user = User()
    @State private var showingSheet = false
    @State private var showingListOfRowsSheet = false
    
        var body: some View {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName).")
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                Button("Second View"){
                    showingSheet.toggle()
                }
                Button("Deleting items using onDelete() View"){
                    showingListOfRowsSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    Secondview(name:"Hina")
                }
                .sheet(isPresented: $showingListOfRowsSheet) {
                    ListOfRowsView()
                }
            }
        }
}

struct ListOfRowsView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }.onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }.toolbar {
                EditButton()
                Button("X"){
                    dismiss()
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct Secondview: View{
    @Environment(\.dismiss) var dismiss
    let name:String
    var body: some View{
        VStack{
            Text("Hello \(name)")
            
            Button("Dismiss the sheet"){
                dismiss()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
