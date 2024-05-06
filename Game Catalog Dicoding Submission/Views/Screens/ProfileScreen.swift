//
//  ProfileScreen.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 03/05/24.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var isEditProfilePresented = false
    @State private var editedName = UserDefaults.standard.string(forKey: "userName") ?? "Dion Pamungkas"
    @State private var editedAboutMe = UserDefaults.standard.string(forKey: "userAboutMe") ??
            "I'm a Software Engineer Backend based in Indonesia 🇮🇩. " +
            "I have a strong affinity for creating beautiful and highly functional websites."

    var body: some View {
            VStack(alignment: .center, spacing: 10) {
                Image("dionMe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 240)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white, lineWidth: 4))
                    .shadow(radius: 5)
                Text(editedName)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top)

                HStack(spacing: 30) {
                    ForEach(socialMediaLogos, id: \.name) { socialMedia in
                        NavigationLink(destination: DetailSosmedScreen(url: socialMedia.url)) {
                            Image(socialMedia.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text("About Me")
                        .font(.title2)
                    Text(editedAboutMe)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton
                    .sheet(isPresented: $isEditProfilePresented) {
                        EditProfileView(
                            editedName: $editedName,
                            editedAboutMe: $editedAboutMe,
                            isEditProfilePresented: $isEditProfilePresented
                        )
                    }
                }
            }
            .navigationTitle("About")
            .padding()
        }

    private var editButton: some View {
        Button(action: {
            isEditProfilePresented.toggle()
        }, label: {
            Image(systemName: "pencil")
                .foregroundColor(Color("brandColor"))
                .frame(width: 40, height: 40)
                .padding()
        })
    }
}

#Preview {
    ProfileScreen()
        .preferredColorScheme(.dark)
}
