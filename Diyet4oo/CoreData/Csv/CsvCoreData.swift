import Foundation
import CoreData

class CSVImporter {
    
    static func importCSVInBackground(named fileName: String, container: NSPersistentContainer) {
        if UserDefaults.standard.bool(forKey: "CSVDataImported") {
            DispatchQueue.main.async {
                print("CSV zaten yüklendi.")
            }
            return
        }
        DispatchQueue.global(qos: .background).async {
            guard let parsedData = parseCSV(named: fileName) else {
                
                return
            }
            
            let context  = container.newBackgroundContext()
            let insertRequest = NSBatchInsertRequest(entityName: "Food", objects: parsedData)
            
            do {
                try context.execute(insertRequest)
                try context.save()
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "CSVDataImported")
                }
                
            } catch {
                
            }
        }
    }
    
    private static func parseCSV(named filename: String) -> [[String: Any]]? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "csv"),
              let content = try? String(contentsOfFile: path, encoding: .utf8)
        else { return nil }
        
        let rows = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard !rows.isEmpty else { return nil }
        
        let columns = rows[0].components(separatedBy: ",")
        var result = [[String: Any]]()
        
        for row in rows.dropFirst() {
            let values = row.components(separatedBy: ",")
            var dict = [String: Any]()
            
            for (index, column) in columns.enumerated() {
                guard index < values.count else { continue }
                let value = values[index].trimmingCharacters(in: .whitespaces)
                
                switch column {
                case "Malzeme Adı":
                    dict["name"] = value.isEmpty ? nil : value as NSString
                    
                case "Porsiyon (g)":
                    dict["portion"] = Double(value) ?? 0.0
                    
                case "Enerji (kcal)":
                    dict["energy"] = Int16(value) ?? 0
                    
                case "Yağ (g)":
                    dict["fat"] = Double(value) ?? 0.0
                    
                case "Karbonhidrat (g)":
                    dict["carb"] = Double(value) ?? 0.0
                    
                case "Protein (g)":
                    dict["protein"] = Double(value) ?? 0.0
                    
                case "Şeker (g)":
                    // Boşsa nil, değilse NSNumber
                    dict["sugar"] = value.isEmpty ? nil : NSNumber(value: Double(value) ?? 0.0)
                    
                case "Fiber (g)":
                    // Boşsa nil, değilse NSNumber
                    dict["fiber"] = value.isEmpty ? nil : NSNumber(value: Double(value) ?? 0.0)
                    
                default:
                    print("Bilinmeyen sütun: \(column)")
                }
            }
            
            guard
                dict["portion"] != nil,
                dict["energy"] != nil,
                dict["fat"] != nil,
                dict["carb"] != nil,
                dict["protein"] != nil
            else {
                
                continue
            }
            result.append(dict)
        }
        
        return result
    }
}
