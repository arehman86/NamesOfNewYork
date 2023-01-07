import Foundation

class BabyInfoModel
{
    func fetchBabyInfos(completion: @escaping ([BabyInfo]) -> Void)
    {
        if let fileURL = Bundle.main.url(forResource: "babyNames", withExtension: "json")
        {
            do
            {
                let data = try Data(contentsOf: fileURL)
                completion(self.getBabyInfos(data: data))
            }
            catch
            {
                print("Error decoding baby names: \(error)")
            }
        }
    }
    
    func fetchBabyInfos(_ url: URL, completion: @escaping ([BabyInfo]) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching baby names: \(error)")
                return
            }
            guard let data = data else {
                print("No data returned by API")
                return
            }
            completion(self.getBabyInfos(data: data))
        }
        task.resume()
    }
    
    private func getBabyInfos(data: Data) -> [BabyInfo]
    {
        do
        {
            let decoder = JSONDecoder()
            let babyNamesArray = try decoder.decode([[String]].self, from: data)
            var babyInfos: [BabyInfo] = []
            
            for babyNameArray in babyNamesArray
            {
                let babyName = BabyInfo(data: babyNameArray)
                babyInfos.append(babyName)
            }
            
            return babyInfos
        }
        catch
        {
            return []
        }
    }
}
