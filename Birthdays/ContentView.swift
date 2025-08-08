//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

struct Birthdays: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}

struct ContentView: View {
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) {friend in HStack {
                    HStack {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    } //end row
                }//end iterative row parameter
                } //end iteration
                .onDelete(perform: deleteFriend)
            } //end friend list
            
            .navigationTitle("Birthdays")
            
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    
                    DatePicker(selection: $newBirthday, in:Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                        .textFieldStyle(.roundedBorder)}
                    
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = Date.now
                    }
                    .bold()
                    
                }//end vstack
                .padding()
                .background(.bar)
            } //safearea placement
            
        }//end navigationStack
        
        
    } //end body
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        } //end closure
    } //end function
    
} //end contentview
    
    #Preview {
        ContentView()
            .modelContainer(for: Friend.self, inMemory: true)
    }

