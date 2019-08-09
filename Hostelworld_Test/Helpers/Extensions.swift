//
//  Extensions.swift

import UIKit

// get the appVersion
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

extension UIViewController {
    func presentAlert(withTitle title: String, message : String?, completion: @escaping ()->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Log Out", style: .default) { action in
            print("You've pressed OK Button")
            completion()
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            print("You've pressed Cancel Button")
        }
        alertController.addAction(CancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// show/hide views
extension UITabBar {
    func hide() {
        self.isHidden = true
    }
    func show() {
        self.isHidden = false
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
extension UILabel {
    convenience init(text: String, color: UIColor = UIColor.black, fontStyle: UIFont = UIFont.systemFont(ofSize: 12)) {
        self.init()
        self.text = text
        self.textColor = color
        self.font = fontStyle
    }
}

extension UIView {
    func setMaterialDesignTheme(){
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.cornerRadius = 8.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}

extension UIView {
    enum Cornors {
        case topLeftRight
        case topLeftBottomRight
        case bottomLeftTopleft
        case leftTopBottomLeft
    }
    func roundCorners(corners: Cornors, radius: CGFloat) {
         self.layer.cornerRadius = radius
        switch corners {
        case .topLeftRight:
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        case .topLeftBottomRight:
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        case .bottomLeftTopleft:
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner]
        case .leftTopBottomLeft:
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        default: () //TODO: remove this case
        }
    }
}

extension UIImageView {
    static func getUIImageView(frame: CGRect = .zero, image: UIImage, contentMode: ContentMode, radius: CGFloat = 0, clipsToBounds: Bool = true) -> UIImageView {
        let im = UIImageView(frame: frame)
        im.image = image
        im.contentMode = contentMode
        im.clipsToBounds = clipsToBounds
        im.layer.cornerRadius = radius
        return im
    }
}

extension UIView {
    func getLine(width: CGFloat, heigh: CGFloat = 1, color: UIColor = .lightGray) -> UIView {
        let view = UIView()
        view.setViewCGRect(width: width, height: heigh)
        view.backgroundColor = color
        return view
    }
}

// view Rect
extension UIView {
    func setViewCGRect(width: CGFloat, height: CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// View layout
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left  = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
