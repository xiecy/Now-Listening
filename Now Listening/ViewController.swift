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
        
        getPlayerStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    
    func getPlayerStatus() {
        let player = MPMusicPlayerController.systemMusicPlayer()
        if let mediaItem = player.nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as! String
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as! String
            
            songTitle.text = title;
            songArtist.text = artist;
            
            print("\(title) on \(albumTitle) by \(artist)")
            
            makeUploadRequest(track: title)
        }
        else {
            print("error")
        }
    }
    
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
    
    func makeUploadRequest (track: String?) {
        APIModule.sharedModule.upload(track: track, completionHandler: { data in
            print("upload success")
        }, errorHandler: { error in
            print("error:\(error)")
        })
    }

}

