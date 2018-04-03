
import UIKit
import MediaPlayer
import AVFoundation

class SongsController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                //let imageURL = URL(string: "http://www.friendstamilmp3.com/songs2/A-Z%20Movie%20Songs/Mersal%20(2017)/Maacho%20Ennacho.mp3")!
                
                //Create URL to the source file you want to download
                let fileURL = URL(string: "http://www.friendstamilmp3.com/songs2/A-Z%20Movie%20Songs/Mersal%20(2017)/Maacho%20Ennacho.mp3")
                
                let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
                let destinationFileUrl = documentsUrl.appendingPathComponent(fileURL!.lastPathComponent)
                
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
                
                let request = URLRequest(url:fileURL!)
                
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                    if let tempLocalUrl = tempLocalUrl, error == nil {
                        // Success
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            print("Successfully downloaded. Status code: \(statusCode)")
                        }
                        
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                        
                    } else {
                        print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
                    }
                }
                task.resume()
                
                self.playSongs(genre: "Romance")
            }
        }
    }
    
    
    
    func playSongs(genre: String) {
        
        musicPlayer.stop()
        
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value:genre, forProperty: MPMediaItemPropertyAssetURL)
        query.addFilterPredicate(predicate)
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        if var fileURL = try? FileManager.default.contentsOfDirectory(atPath: documentDirectory) {
            fileURL[0] = documentsUrl.appendingPathComponent(fileURL[0]).absoluteString
//            musicPlayer.setQueue(with:query)
//            musicPlayer.shuffleMode = .songs
//            musicPlayer.setQueue(with:fileURL)
//            musicPlayer.play()
            
            do {
                //let imageData = try Data(contentsOf: URL(string: documentsUrl.appendingPathComponent(fileURL[0]).path)!)
                
                if FileManager.default.fileExists(atPath: documentsUrl.appendingPathComponent(fileURL[0]).path){
                    if let cert = NSData(contentsOfFile: documentsUrl.appendingPathComponent(fileURL[0]).path) {
                        
                    }
                }
                
                audioPlayer = try AVAudioPlayer()
                guard let player = audioPlayer else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func stopPlayer(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    
    @IBAction func playNextSong(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
}

