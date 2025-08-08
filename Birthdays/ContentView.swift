//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

@main
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
            List(friends) {friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                } //end hstack
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
} //end contentview

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
