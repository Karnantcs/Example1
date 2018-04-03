
import UIKit
import MediaPlayer

class SongsControllerBkp: UIViewController {
    
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
                self.playSongs(genre: sender.currentTitle!)
            }
        }
    }
    
    func playSongs(genre: String) {
        
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value:genre, forProperty: MPMediaItemPropertyGenre)
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with:query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
    }
    
    
    @IBAction func stopPlayer(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    
    @IBAction func playNextSong(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
}


