import SwiftUI

struct ContentView: View {
    @State private var countries: [Country] = []

    var body: some View {
        Button {
            Task { await fetchCountries() }
        } label: {
            Text("Trykk på meg")
        }
        .buttonStyle(BorderedProminentButtonStyle())

        List {
            ForEach(countries) { country in
                Section {
                    LabeledContent("Country name", value: "\(country.name.common) (\(country.id)) \(country.flag)")
                    LabeledContent("Capital", value: country.capital.first ?? "")
                    LabeledContent("Population", value: "\(country.population)")
                    LabeledContent("Region", value: "\(country.region)")
                    LabeledContent("Currency", value: currencyString(for: country))
                }
            }
        }
    }

    /// Slå sammen alle valutaer til en streng.
    ///
    /// Tar alle valuter for et gitt land, og konkatinerer dem inn i en streng med.
    ///
    /// - Parameter country: Et gitt land.
    /// - Returns: En string per valuta, per land. Eks.: NOK, Norwegian Krone (kr)
    func currencyString(for country: Country) -> String {
        country.currencies.map { code, info in
            return "\(code), \(info.name) (\(info.symbol))"
        }
        .joined(separator: "\n")
    }

    /// Hent data fra API.
    func fetchCountries() async {
        guard let url = URL(string: "https://restcountries.com/v3.1/all?fields=cca3,name,population,region,capital,flag,subregion,currencies") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Kunne ikke hente data ass...")
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
