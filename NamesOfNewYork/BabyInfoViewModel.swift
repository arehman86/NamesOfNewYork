import Foundation

class BabyInfoViewModel
{
    private let model: BabyInfoModel
    var babyInfos: [BabyInfo]
    
    init()
    {
        model = BabyInfoModel()
        babyInfos = []
    }
    
    func fetchBabyNames()
    {
        model.fetchBabyInfos { [weak self] infos in
            self?.babyInfos = infos
            // Notify the view to update itself
        }
    }
    
    func getBabyInfo(gender: Gender) -> BabyInfo?
    {
        guard !self.babyInfos.isEmpty else {
            return nil
        }
        
        let dataByGender = self.babyInfos.filter({ $0.gender == gender.rawValue })
        
        let sortedData = dataByGender.sorted { (info1, info2) -> Bool in
            return info1.numberOfBabies > info2.numberOfBabies
        }
        
        let randomThreshold = min(sortedData.count, 5)
        
        var arr = [BabyInfo]()
        for _ in 0...randomThreshold {
            let randomIndex = Int(arc4random_uniform(UInt32(sortedData.count)))
            arr.append(sortedData[randomIndex])
        }
        
        return arr.first
    }
}
