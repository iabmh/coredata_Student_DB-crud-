

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var searchDisplay: UITextView!
    
    @IBOutlet var namefield: UITextField!
    
    @IBOutlet var subjectfield: UITextField!
    
    @IBOutlet var addressfield: UITextField!
    
    @IBOutlet var searchfield: UITextField!
    
    

    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDisplay.isHidden = true
        searchfield.placeholder = "Enter student name"


        
    }
    @IBAction func saveButton(_ sender: Any) {
        
        let newstudent = NSEntityDescription.insertNewObject(forEntityName: "Students", into: context)
        newstudent.setValue(self.namefield.text, forKey: "name")
        newstudent.setValue(self.subjectfield.text, forKey: "subject")
        newstudent.setValue(self.addressfield.text, forKey: "address")
        
        do{
            try context.save()
            namefield.text = ""
            addressfield.text = ""
            subjectfield.text = ""
        }
        catch{
            
            print("Error")
            
        }
    }


    @IBAction func ShowdataBtn(_ sender: Any) {
        
        let strybrd = UIStoryboard(name: "Main", bundle: nil)
        let Tableview = strybrd.instantiateViewController(withIdentifier: "stddb") as! StudendDB_TVC
        self.navigationController?.pushViewController(Tableview, animated: true)
        
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        
        let request = NSFetchRequest <NSFetchRequestResult>(entityName: "Students")
        let searchstr = searchfield.text
        request.predicate = NSPredicate(format: "name == %@", searchstr!)
        var outputline = ""
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for student in result{

                    var studentname = (student as AnyObject).value(forKey: "name") as! String
                    var studentaddress = (student as AnyObject).value(forKey: "address") as! String
                    var studentsubject = (student as AnyObject).value(forKey: "subject") as! String
                    outputline += "name : \(studentname) \n subject :\(studentsubject) \n address : \(studentaddress)"
                }
                
                
            }
            else {
                outputline = "No match found"
                
            }
            
            self.searchDisplay.text = outputline
            searchDisplay.isHidden=false
            
        }
        catch{
            
            print("error")
            
            
        }
        
        }
    @IBAction func UpdateBtn(_ sender: Any) {
         let request = NSFetchRequest <NSFetchRequestResult>(entityName: "Students")
        let updatestr = namefield.text
        request.predicate = NSPredicate(format: "name == %@", updatestr!)

        do{
            let result = try context.fetch(request)
            
            if result.count != 0{
                
                for student in result{
                   (student as AnyObject).setValue(addressfield.text, forKey: "address")
                    (student as AnyObject).setValue(subjectfield.text, forKey: "subject")
                    }
                
            }
            
            }
            
        catch{
            print("error")
            
        }
        do{
            try context.save()
            
        }
        catch{
            print ("error")
        }
        
        
    }
    
    
}


