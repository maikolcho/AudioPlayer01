//
//  ViewController.swift
//  AudioPlayer01
//
//  Created by Maik on 12/3/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var audioURLs: [URL] = []
    var songImages: [UIImage] = []
    var currentSongIndex: Int = 0
    
    @IBOutlet weak var volumenControl: UISlider!
    @IBOutlet weak var songImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio()
    }
    
    
    
    
    // MARK: - Button Action
    
    @IBAction func playButtonAction(_ sender: Any) {
        audioPlayer?.play()
      
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        audioPlayer?.pause()
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    
    @IBAction func goBackwardTen(_ sender: Any) {
        if let currentTime = audioPlayer?.currentTime, currentTime > 10 {
            audioPlayer?.currentTime = currentTime - 10
        } else {
            audioPlayer?.currentTime = 0
        }
        
      
    }
    
    @IBAction func nextSong(_ sender: Any) {
            currentSongIndex = (currentSongIndex + 1) % audioURLs.count
            playSong(at: currentSongIndex)
        }
    
    
    @IBAction func previousSong(_ sender: Any) {
      
        currentSongIndex = (currentSongIndex - 1 + audioURLs.count) % audioURLs.count
        playSong(at: currentSongIndex)
    }
    
    @IBAction func goForwardTen(_ sender: Any) {
        if let currentTime = audioPlayer?.currentTime, let duration = audioPlayer?.duration {
            let newTime = min(currentTime + 10, duration)
                audioPlayer?.currentTime = newTime
           
            }
            
        }

    
    @IBAction func volumenButtonAction(_ sender: UISlider) {
        audioPlayer?.volume = volumenControl.value
    }
    
    private func loadAudio() {
        guard let song1URL = Bundle.main.url(forResource: "black", withExtension: "mp3"),
           let song1Image = UIImage(named: "diosa"),
           let song2URL = Bundle.main.url(forResource: "rock", withExtension: "mp3"),
           let song2Image = UIImage(named: "angel_caido") else {
        print("Error loading audio files or images")
            return
        }
            
            
            audioURLs = [song1URL, song2URL]
            songImages = [song1Image, song2Image]
            print("Audio URLs loaded successfully: \(audioURLs)")
        
            // Reproducir la primera cancion al cargar 
            playSong(at: 0)
            
        }
    

        
    private func playSong(at index: Int) {
           guard index >= 0 && index < audioURLs.count else {
               print("Invalid song index")
               return
           }
        
        // Cambiar la imagen correspondiente a la canción
                songImageView.image = songImages[index]
           
           
           let songURL = audioURLs[index]
           do {
               audioPlayer = try AVAudioPlayer(contentsOf: songURL)
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()
           } catch let error {
               print("Error playing song: \(error.localizedDescription)")
           }
       }
   }


