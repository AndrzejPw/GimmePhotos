//
//  ViewController.swift
//  GimmePhotos
//
//  Created by andrzej.biernacki on 28/08/2021.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBOutlet weak var srcDirectoryLabel: NSTextField!
    @IBAction func onSelectSrcDirectoryButtonClicked(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        
        
          if dialog.runModal() == NSApplication.ModalResponse.OK {
            srcDirectoryLabel.stringValue = dialog.url?.path ?? ""
          } else {
            // Cancel was pressed
          }
        
        // Create a document picker for directories.
//        let documentPicker =
//            UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
//        documentPicker.delegate = self
//
//        // Set the initial directory.
//        //documentPicker.directoryURL = startingDirectory
//
//        // Present the document picker.
//        present(documentPicker, animated: true, completion: nil)
    }
    
}

