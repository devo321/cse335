//
//  ContentView.swift
//  lectureActiviy-SwiftUI
//
//  Created by Deven Pile on 1/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        mainView()
    }
}

struct mainView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var greeting: String = ""
    var body: some View {
        VStack{
            Text("Enter Name and age")
                .bold()
            Spacer()
            HStack{
                Text("First Name: ")
                Spacer()
                Spacer()
                
                TextField("Enter First Name", text: $firstName, onEditingChanged: {
                    (changed) in print("First Name onEditingChanged - \(changed)")
                })
            }
            HStack{
                Text("Last Name: ")
                Spacer()
                Spacer()
                
                TextField("Enter Last Name", text: $lastName, onEditingChanged: {
                    (changed) in print("Last Name onEditingChanged - \(changed)")
                })
            }
            Spacer()
            Button(action: {
                self.greeting = "\(self.firstName) \(self.lastName) Welcome to CSE335"
            }, label: {
                Text("Submit")
            })
            Spacer()
            Text(greeting)
            Spacer()
            
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


