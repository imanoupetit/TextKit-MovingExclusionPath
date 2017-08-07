
import UIKit

class BadgeView: UIView {
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var roundedPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(true)
        let path = roundedPath
        UIColor.orange.setFill()
        path.fill()
    }
    
}
