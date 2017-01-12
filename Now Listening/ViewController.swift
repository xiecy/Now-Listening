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
            
            let trackData = ["title": title, "artist": artist]
            
            print("\(title) on \(albumTitle) by \(artist)")
            
            makeUploadRequest(track: trackData as Data)
        }
        else {
            print("error")
        }
    }
    
    func makeUploadRequest (track: Data?) {
        APIModule.sharedModule.upload(track: track, completionHandler: { data in
            print("upload success")
        }, errorHandler: { error in
            print("error:\(error)")
        })
    }

}

