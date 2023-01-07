import UIKit

enum Gender: String {
    case male = "MALE"
    case female = "FEMALE"
}

class ViewController: UIViewController
{
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ethnicityLabel: UILabel!
    @IBOutlet weak var noOfBabiesLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    var selectedGender: Gender = .male
    let babyInfoViewModel = BabyInfoViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        babyInfoViewModel.fetchBabyNames()
        updateButtons()
    }
    
    private func updateButtons()
    {
        maleButton.isSelected = selectedGender == .male
        femaleButton.isSelected = selectedGender == .female
        
        maleButton.tintColor = maleButton.isSelected ? .systemRed : .systemBlue
        femaleButton.tintColor = femaleButton.isSelected ? .systemRed : .systemBlue
    }
}

extension ViewController
{
    @IBAction func onSelectMale(_ sender: Any)
    {
        selectedGender = .male
        updateButtons()
    }
    
    @IBAction func onSelectFemale(_ sender: Any)
    {
        selectedGender = .female
        updateButtons()
    }
    
    @IBAction func onGenerate(_ sender: Any)
    {
        guard let babyInfo = babyInfoViewModel.getBabyInfo(gender: selectedGender) else {
            return
        }
        
        self.nameLabel.text = babyInfo.name
        self.yearLabel.text = String(babyInfo.yearOfBirth)
        self.genderLabel.text = babyInfo.gender
        self.ethnicityLabel.text = babyInfo.ethnicity
        self.noOfBabiesLabel.text = String(babyInfo.numberOfBabies)
        self.rankLabel.text = String(babyInfo.rank)
    }
}

