//
//  EditProfileView.swift
//  Gameformation
//
//  Created by Luis Genesius on 03/09/21.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name: String = UserDefaults.standard.string(forKey: "profileName") ?? "No Name"
    @State var origin: String = UserDefaults.standard.string(forKey: "profileOrigin") ?? "No Origin"
    @State var description: String = UserDefaults.standard.string(forKey: "profileDescription") ?? "No Description"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.3803921569, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.537254902, green: 0.1450980392, blue: 0.2431372549, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Section(header: Text("Edit Your Name").padding(.top)) {
                    TextField("Edit your name...", text: $name)
                        .textFieldStyle()
                }
                Section(header: Text("Edit Your Origin").padding(.top)) {
                    TextField("Edit your origin...", text: $origin)
                        .textFieldStyle()
                }
                Section(header: Text("Edit Your Description").padding(.top)) {
                    TextField("Edit your description...", text: $description)
                        .textFieldStyle()
                }
                Spacer()
                Button(action: {
                    UserDefaults.standard.setValue(name, forKey: "profileName")
                    UserDefaults.standard.setValue(origin, forKey: "profileOrigin")
                    UserDefaults.standard.setValue(description, forKey: "profileDescription")
                    
                    NotificationCenter.default.post(name: .refreshAbout, object: nil)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.systemBlue))
                .cornerRadius(10.0)
                .padding()
            }
        }
        .navigationBarTitle("Edit Profile")
    }
}

extension TextField {
    func textFieldStyle() -> some View {
        self
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.horizontal)
    }
}
