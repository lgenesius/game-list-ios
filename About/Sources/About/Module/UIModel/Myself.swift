//
//  File.swift
//  
//
//  Created by Luis Genesius on 03/12/21.
//

import Foundation

public struct Myself {
    public let myImageName = "me"
    public let myName = "Luis Genesius"
    public let myOrigin = "Singkawang, Kalimantan Barat"
    
    public let myBackground = "Saya adalah mahasiswa Universitas Bina Nusantara yang mengambil jurusan Teknik Informatika."
    public let myPurpose = "Memiliki tujuan untuk menjadi seorang iOS Developer yang handal."
    public let myPassion = "Saya memiliki passion untuk mengembangkan aplikasi karena"
    public let myReason = "dapat menghasilkan sebuah produk yang bisa memberikan manfaat bagi banyak orang."
    
    public init() {}
    
    public var myDescription: String {
        myBackground + " " + myPurpose + " " + myPassion + " " + myReason
    }
}
