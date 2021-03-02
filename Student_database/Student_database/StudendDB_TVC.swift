
import UIKit

class StudendDB_TVC: UITableViewController {
    
    @IBOutlet var tblview: UITableView!

    var studentlist:[Students] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchdata() {
        
        do {
            studentlist = try context.fetch(Students.fetchRequest())
        }catch
        {
            print("error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchdata()
        self.tblview.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return studentlist.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let studentrecord = studentlist[indexPath.row]
        
        cell.textLabel?.text = "name : \(studentrecord.name!), subject : \(studentrecord.subject!), address : \(studentrecord.address!)"

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let deletecell = studentlist[indexPath.row]
            context.delete(deletecell)
            do {
                studentlist = try context.fetch(Students.fetchRequest())
            }catch
            {
                print("error")
            }
            tblview.reloadData()
           
        }/* else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } */
    }
  

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
