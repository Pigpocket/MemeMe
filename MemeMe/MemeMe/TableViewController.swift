//
//  TableViewController.swift
//  MemeMe
//
//  Created by Tomas Sidenfaden on 7/31/17.
//  Copyright © 2017 Tomas Sidenfaden. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: Declare variables
    
    var memes: [Meme]!
    var memeToEdit: Meme?
    
    // MARK: Declare outlets
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
   
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load memes from App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let meme = self.memes[indexPath.row]
        
        // Load data and format cell
        cell.memeImageView.image = meme.memedImage
        cell.memeImageView.contentMode = .scaleAspectFit
        cell.topTextLabel.text = meme.topText
        cell.topTextLabel.lineBreakMode = .byWordWrapping
        cell.bottomTextLabel.text = meme.bottomText
        cell.bottomTextLabel.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        controller.memeToEdit = memes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: Implement swipe right to delete 
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            // Remove from table view
            memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Remove from data array
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
        }
    }
    
    // MARK: Actions
    
    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelSegueFromTableView", sender: self)
    }
    
    @IBAction func addMeme(_ sender: Any) {
        self.performSegue(withIdentifier: "addMemeFromTableView", sender: self)
    }
}
