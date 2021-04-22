//
//  VideoPlayer.swift
//  Dream House
//
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class AvpVideoPlayer: UIView {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var playerController = AVPlayerViewController()
    var isLoop: Bool = false
    var isPlayed = false
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configure(url: String) {
        if let videoURL = URL(string: url) {
            
            
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resize
            
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }
    
    func play() {
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
            //            self.isPlayed = true
            
            self.playerController.player = player
            
            self.playerController.view.frame = bounds
            
            self.addSubview(self.playerController.view)
            
        }
    }
    
    func pause() {
        player?.pause()
        //        self.isPlayed = false
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player?.pause()
            player?.seek(to: CMTime.zero)
            player?.play()
        }
    }
}
