//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by bender on 6/20/15.
//  Copyright © 2015 claudiucancode. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSyncth = NSSpeechSynthesizer()
//    var isStarted: Bool = true
    
    var isStarted: Bool = false {
        didSet {
            updateButtons   ()
        }
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSyncth.delegate = self
    }
    
    // MARK: - NSSpeechSynthesizerDelegate

    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
            isStarted = false
            print("finishedSpeaking=\(finishedSpeaking)")
    }

    
    // MARK: - Action methods
    
    @IBAction func speakIt(sender: NSButton) {
        let string = textField.stringValue
        if string.isEmpty {
            print("String from \(textField) is emppty!")
        } else {
          print("String has values: \(textField.stringValue)")
            speechSyncth.startSpeakingString(string)
            isStarted = true
        }
    }
    
    @IBAction func stopIt(sender: NSButton) {
        print("stop button pressed")
        speechSyncth.stopSpeaking()
        isStarted = false
    }

    func updateButtons() {
        if isStarted {
            speakButton.enabled = false
            stopButton.enabled = true
        } else {
            speakButton.enabled = true
            stopButton.enabled = false
        }
    }
}
