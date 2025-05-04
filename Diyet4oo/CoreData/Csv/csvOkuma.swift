//
//  csvOkuma.swift
//  Diyet4oo
//
//  Created by hamid on 4.05.2025.
//

import Foundation

struct csvOkuma {
    
    
    static func parseCSV(named filename: String) -> [[String: Any]]? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "csv"),
              let content = try? String(contentsOfFile: path, encoding: .utf8)
        else { return nil }
        
        let rows = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard !rows.isEmpty else { return nil }
        
        let columns = rows[0].components(separatedBy: ",") // Başlık satırı
        var result = [[String: Any]]()
        
        for row in rows.dropFirst() { // Başlığı atla
            let values = row.components(separatedBy: ",")
            var dict = [String: Any]()
            
            for (index, column) in columns.enumerated() {
                guard index < values.count else { continue }
                
                let value = values[index].trimmingCharacters(in: .whitespaces)
                
                // Tür Dönüşümleri
                switch column {
                case "Porsiyon (g)", "Yağ (g)", "Karbonhidrat (g)",
                     "Protein (g)", "Şeker (g)", "Fiber (g)":
                    dict[column] = Double(value) ?? 0.0
                case "Enerji (kcal)":
                    dict[column] = Int16(value) ?? 0
                default:
                    dict[column] = value
                }
            }
            result.append(dict)
        }
        return result
    }
}
