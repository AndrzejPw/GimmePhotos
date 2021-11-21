//
//  ViewController.swift
//  GimmePhotos
//
//  Created by andrzej.biernacki on 28/08/2021.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

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
        refreshCopyButtonState()
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = true
        
          if dialog.runModal() == NSApplication.ModalResponse.OK {
              targetDirectoryLabel.stringValue = dialog.url?.path ?? ""
              refreshCopyButtonState()
          } else {
            // Cancel was pressed
          }
    }

    @IBOutlet weak var userInputTextField: NSTextField!{
        didSet {
            userInputTextField.delegate = self
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        refreshCopyButtonState()
    }
    @IBAction func onSelectSrcDirectoryButtonClicked(_ sender: Any) {
        let dialog = NSOpenPanel()
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        
        
          if dialog.runModal() == NSApplication.ModalResponse.OK {
              srcDirectoryLabel.stringValue = dialog.url?.path ?? ""
              refreshCopyButtonState()
          } else {
            // Cancel was pressed
          }
    }
    func refreshCopyButtonState(){
        if (!srcDirectoryLabel.stringValue.isEmpty && !targetDirectoryLabel.stringValue.isEmpty && !userInputTextField.stringValue.isEmpty){
            CopyFilesButton.isEnabled = true
        } else {
            CopyFilesButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var CopyFilesButton: NSButtonCell!
    @IBAction func onRunButtonClicked(_ sender: Any) {
        
        do{
            let result = try GimmePhotos.copy(from: srcDirectoryLabel.stringValue, to: targetDirectoryLabel.stringValue, fileInputFromUser: userInputTextField.stringValue)
            let dialog = NSAlert()
            if (result.values.contains { $0 == nil}){
                dialog.alertStyle = .warning
                let filesWithoutMatch = result.filter { $0.value == nil }.keys.joined(separator: " ,")
                let message = "Job finished. Couldn't find matching files for: \(filesWithoutMatch)"
                dialog.messageText = message
                
            } else {
                dialog.alertStyle = .informational
                let message = "Job finished. \(result.count) files copied."
                dialog.messageText = message
            }
            dialog.runModal()
        } catch {
            print("Unexpected error: \(error).")
            let dialog = NSAlert(error: error)
            dialog.runModal()
        }
    }
    func displayError(message: String) {
//            let dialog = NSAlert(
    }
    
}

