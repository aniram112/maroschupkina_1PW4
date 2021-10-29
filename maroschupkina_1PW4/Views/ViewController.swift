//
//  ViewController.swift
//  maroschupkina_1PW4
//
//  Created by Marina Roshchupkina on 27.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLabel: UILabel!
    

    var notes: [Note] = [] {
        didSet {
            collectionLabel.isHidden = true
            collectionView.insertItems(at: [IndexPath(row: notes.count - 1, section: 0)])
        }
    }
    
   
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "CoreDataNotes")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(createNote(sender:)))
        // Do any additional setup after loading the view.
    }
    
    func saveChanges() {
        if context.hasChanges {
            try? context.save()
        }
        if let notes = try? context.fetch(Note.fetchRequest()) as? [Note] {
            self.notes = notes
        } else {
            self.notes = []
        }
    }
    
    func loadData() {
        if let notes = try? context.fetch(Note.fetchRequest()) as [Note] {
            self.notes = notes.sorted(by: {$0.creationDate.compare($1.creationDate) == .orderedDescending})
        } else {
            self.notes = []
        }
    }
    
    
    @objc func createNote(sender: UIBarButtonItem) {
        guard let vc =
        storyboard?.instantiateViewController(withIdentifier:
        "NoteViewController") as? NoteViewController else {
        return
        }
        vc.outputVC = self
        navigationController?.pushViewController(vc, animated: true)
    }

}
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
}
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.titleLabel.text = notes[indexPath.row].title
        cell.descriptionLabel.text =  notes[indexPath.row].descriptionText
        return cell
    }
}
