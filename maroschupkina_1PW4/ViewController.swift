//
//  ViewController.swift
//  maroschupkina_1PW4
//
//  Created by Marina Roshchupkina on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLabel: UILabel!
    
    var notes: [Note] = [] {
        didSet{
            collectionLabel.isHidden = notes.count != 0
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(createNote(sender:)))
        // Do any additional setup after loading the view.
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
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.descriptionLabel.text = note.description
        return cell
    }
}
