import UIKit
class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width: 125, height: 125))
        imageView.image = UIImage(named: "Image")
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.addSubview(imageView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {
            self.animate()
        })
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffx/2),
                y: diffy/2,
                width: size,
                height: size
            )
            
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//                    let vc = ConnexionViewController()
//                    vc.modalTransitionStyle = .crossDissolve
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true)
                    self.performSegue(withIdentifier: "animationToConnexion", sender: "yes")
                })
            }
        })
    }

    
}
