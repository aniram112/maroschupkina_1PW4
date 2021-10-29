//
//  NoteViewController.swift
//  maroschupkina_1PW4
//
//  Created by Marina Roshchupkina on 28.10.2021.
//

import UIKit
import CoreData

class NoteViewController: UIViewController{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    var outputVC: ViewController!
    var model: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapSaveNote(button:)))
        if (model != nil) {
            titleTextField.isUserInteractionEnabled = false
            textView.isEditable = false
            textView.text = model?.descriptionText
            titleTextField.text = model?.title
        }
    }
    
    @objc
    func didTapSaveNote(button: UIBarButtonItem) {
        if (model == nil) {
            let title = titleTextField.text ?? ""
            let descriptionText = textView.text ?? ""
            if !title.isEmpty {
                let newNote = Note(context: outputVC.context)
                newNote.title = title
                newNote.descriptionText = descriptionText as String
                newNote.creationDate = Date()
                outputVC.saveChanges()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
