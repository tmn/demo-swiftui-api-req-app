struct Country: Codable, Identifiable {
    let id: String
    let name: CountryName
    let capital: [String]
    let population: Int
    let region: String
    let flag: String
    let currencies: [String: Currency]

    enum CodingKeys: String, CodingKey {
        case id = "cca3"
        case name
        case capital
        case population
        case region
        case flag
        case currencies
    }
}
