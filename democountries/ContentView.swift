import SwiftUI

struct ContentView: View {
    @State private var countries: [Country] = []

    var body: some View {
        // Yes, en knapp
        Button {
            Task {
                await fetchCountries()
            }
        } label: {
            Text("Trykk på meg")
        }
        .buttonStyle(BorderedProminentButtonStyle())

        // Liste ut alle land
        List {
            ForEach(countries) { country in
                Section {
                    LabeledContent("Country name", value: "\(country.name.common) (\(country.id)) \(country.flag)")
                    LabeledContent("Capital", value: country.capital.first ?? "")
                    LabeledContent("Population", value: "\(country.population)")
                    LabeledContent("Region", value: "\(country.region)")
                }
            }
        }
    }

    // En funksjon som henter data
    func fetchCountries() async {
        guard let url = URL(string: "https://restcountries.com/v3.1/all?fields=cca3,name,population,region,capital,flag,subregion") else {
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
