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
    @IBOutlet weak var targetDirectoryLabel: NSTextField!
    @IBAction func onSelectTargetDirectoryButtonClicked(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = true
        
          if dialog.runModal() == NSApplication.ModalResponse.OK {
              targetDirectoryLabel.stringValue = dialog.url?.path ?? ""
          } else {
            // Cancel was pressed
          }
    }
    @IBOutlet weak var userInputTextField: NSTextFieldCell!
    @IBAction func onSelectSrcDirectoryButtonClicked(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        
        
          if dialog.runModal() == NSApplication.ModalResponse.OK {
              srcDirectoryLabel.stringValue = dialog.url?.path ?? ""
              dialog.url?.startAccessingSecurityScopedResource()
          } else {
            // Cancel was pressed
          }
    }
    
    @IBAction func onRunButtonClicked(_ sender: Any) {
        //TODO add validation
        do{
            try GimmePhotos.copy(from: srcDirectoryLabel.stringValue, to: targetDirectoryLabel.stringValue, fileInputFromUser: userInputTextField.stringValue)
        } catch {
            print("Unexpected error: \(error).")
        }
        
        
    }
    
}

