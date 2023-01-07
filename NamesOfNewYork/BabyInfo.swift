import Foundation

struct BabyInfo: Codable
{
    let yearOfBirth: Int
    let gender: String
    let ethnicity: String
    let name: String
    let numberOfBabies: Int
    let rank: Int
    
    init(data: [String])
    {
        yearOfBirth = Int(data[0]) ?? 0
        gender = data[1]
        ethnicity = data[2]
        name = data[3]
        numberOfBabies = Int(data[4]) ?? 0
        rank = Int(data[5]) ?? 0
    }
}
