//
//  Alert.swift
//  Game Catalog Dicoding Submission
//
//  Created by Dion Arya Pamungkas on 04/05/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidResponse = AlertItem(
        title: Text("Server Error"),
        message: Text("Terjadi kesalahan dalam menerima respon dari server. " +
                          "Silakan coba lagi atau hubungi dukungan teknis jika masalah berlanjut."),
        dismissButton: .default(Text("Ok"))
    )
    static let invalidURL = AlertItem(
        title: Text("Server Error"),
        message: Text("Terjadi kesalahan dalam pemrosesan data. " +
                          "Silakan coba lagi atau hubungi dukungan teknis jika masalah berlanjut."),
        dismissButton: .default(Text("Ok"))
    )
    static let unableToComplete = AlertItem(
        title: Text("Server Error"),
        message: Text("Terjadi kesalahan dalam menyelesaikan permintaan. " +
                          "Silakan coba lagi atau periksa koneksi internet Anda jika masalah berlanjut."),
        dismissButton: .default(Text("Ok"))
    )
    static let invalidData = AlertItem(
        title: Text("Server Error"),
        message: Text("Terjadi kesalahan dalam pemrosesan data. " +
                          "Silakan coba lagi atau hubungi dukungan teknis jika masalah berlanjut."),
        dismissButton: .default(Text("Ok"))
    )
    static let dataNotFound = AlertItem(
        title: Text("Game not found"),
        message: Text("game yang anda cari tidak ditemukan"),
        dismissButton: .default(Text("Ok"))
        )
}
