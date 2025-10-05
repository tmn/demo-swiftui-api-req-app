struct Country: Codable, Identifiable {
    let cca3: String

    // Lokal variabel for "Identifiable"
    var id: String { cca3 }

    let name: CountryName
    let capital: [String]
    let population: Int
    let region: String
    let flag: String
}
