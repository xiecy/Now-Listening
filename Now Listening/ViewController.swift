//
//  ViewController.swift
//  Now Listening
//
//  Created by Clark on 1/12/17.
//  Copyright © 2017 Clark Xie. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initDisplay()
        //updateDisplay()
        /*
        for _ in 1...30 {
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateDisplay), userInfo: nil, repeats: false)
        }
        */
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateDisplay), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var fSongTitle: UILabel!
    @IBOutlet weak var YListening: UILabel!
    @IBOutlet weak var FListening: UILabel!
    @IBOutlet weak var userSwitchLabel: UILabel!
    @IBOutlet weak var userSwitch: UISegmentedControl!
    
    func initDisplay() {
        YListening.text = "You're listening to"
        FListening.text = "Your friend is listening to"
        
        songTitle.text = "Loading..."
        songArtist.text = "Loading..."
        fSongTitle.text = "Loading..."
        
        //userSwitch configuration
        userSwitchLabel.text = "You are"
        userSwitch.setTitle("User1", forSegmentAt: 0)
        userSwitch.setTitle("User2", forSegmentAt: 1)
    }
    
    func updateDisplay() {
        var self_index: Int = userSwitch.selectedSegmentIndex
        
        let player = MPMusicPlayerController.systemMusicPlayer()
        if let mediaItem = player.nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
            
            songTitle.text = title
            songArtist.text = artist
            print("\(title) on \(albumTitle) by \(artist)")
            makeUploadRequest(track: title, index: self_index)
            self.fSongTitle.text = makeRetrieveRequest(index: self_index)
        }
        else {
            print("error")
        }
    }
/*
    func makeLoginRequest() {
        APIModule.sharedModule.login(completionHandler: { data in
            do {
                let responseDict = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let responseKmd = responseDict["_kmd"] as! [String:Any]
                let authtoken = responseKmd["authtoken"] as! [String:Any]
                    print(authtoken)
                APIModule.sharedModule.user = "Kinvey \(authtoken)" as? NSString
            } catch {
                print(error.localizedDescription)
            }
        }) { error in
            print("error:\(error)")
        }
    }
*/
    
    func makeUploadRequest (track: String?, index: Int) {
        APIModule.sharedModule.upload(track: track, index: index, completionHandler: { data in
            print("upload success")
        }, errorHandler: { error in
            print("error:\(error)")
        })
    }
    
    func makeRetrieveRequest(index: Int) -> String {
        var response: String?
        APIModule.sharedModule.retrieve(index: index, completionHandler: { data in
            do {
                let responseDict = try JSONSerialization.jsonObject(with: data) as! NSDictionary
                print(responseDict)
                let responseTitle = responseDict["title"] as! NSString
                print("response title is \(responseTitle)")
                APIModule.sharedModule.fTitle = responseTitle as String
                print(APIModule.sharedModule.fTitle)
            } catch {
                print(error.localizedDescription)
            }
        }) { error in
            print("error:\(error)")
        }
        let fTitle: String = APIModule.sharedModule.fTitle as String
        print("fTitle = \(fTitle)")
        return fTitle
    }
}

