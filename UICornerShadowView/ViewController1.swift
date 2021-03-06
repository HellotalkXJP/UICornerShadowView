//
//  ViewController1.swift
//  UICornerShadowView
//
//  Created by Jiang on 2020/2/11.
//  Copyright © 2020 SilverFruity. All rights reserved.
//

import UIKit
import SFImageMaker
class RandomCell: UITableViewCell{
    @IBOutlet weak var container: SFCSBView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
class ViewController1: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomCell") as! RandomCell
        cell.container.backgroundColor = UIColor.init(red: CGFloat.random(in: 0...10) / 10, green: CGFloat.random(in: 0...10) / 10, blue: CGFloat.random(in: 0...10) / 10, alpha: 1)
        cell.container.cornerRadius = CGFloat(Int.random(in: 10..<20))
        let cornerPositions: [UIRectCorner] = [.topLeft,.topRight,.bottomLeft,.bottomRight]
        var cornerResult = [UIRectCorner]()
        var cornerCount = Int.random(in: 0..<4)
        while cornerCount >= 0 {
            cornerResult.append(cornerPositions[Int.random(in: 0..<4)])
            cornerCount -= 1
        }
        cell.container.rectCornner = UIRectCorner.init(cornerResult)
        
        let shadowPositions: [UIShadowPostion] = [.left,.top,.right,.bottom]
        var shadowResult = [UIShadowPostion]()
        var shadowResultCount = Int.random(in: 0..<4)
        while shadowResultCount >= 0 {
            shadowResult.append(shadowPositions[Int.random(in: 0..<4)])
            shadowResultCount -= 1
        }
        cell.container.shadowPosition = UIShadowPostion.init(shadowResult)
        cell.container.shadowColor = UIColor.black.withAlphaComponent(CGFloat(Int.random(in: 4..<10)) / 10)
        cell.container.shadowRadius = CGFloat(Int.random(in: 8..<20))
        cell.container.borderColor = UIColor.init(red: CGFloat(Int.random(in: 0...10)) / 10, green: CGFloat(Int.random(in: 0...10)) / 10, blue: CGFloat(Int.random(in: 0...10)) / 10, alpha: 1)
        cell.container.borderWidth = CGFloat(Int.random(in: 0..<8))
        
        let borderPositions: [UIBorderPostion] = [.left,.top,.right,.bottom]
        var borderResult = [UIBorderPostion]()
        var borderCount = Int.random(in: 0..<4)
        while borderCount >= 0 {
            borderResult.append(borderPositions[Int.random(in: 0..<4)])
            borderCount -= 1
        }
        if Int.random(in: 0..<5) / 2 == 0{
            cell.container.defautlGeneratorClass = SFGradientImageMaker.self
        }else{
            cell.container.defautlGeneratorClass = SFColorImageMaker.self
        }
        cell.container.handleMakers = { makers in
            if let gradientGenerator = makers.filter({ $0 is SFGradientImageMaker }).first as? SFGradientImageMaker{
                let startColor = UIColor.init(red: CGFloat(Int.random(in: 0...10)) / 10, green: CGFloat(Int.random(in: 0...10)) / 10, blue: CGFloat(Int.random(in: 0...10)) / 10, alpha: 1)
                let endColor = UIColor.init(red: CGFloat(Int.random(in: 0...10)) / 10, green: CGFloat(Int.random(in: 0...10)) / 10, blue: CGFloat(Int.random(in: 0...10)) / 10, alpha: 1)
                gradientGenerator.colors = [startColor, endColor]
                gradientGenerator.locations = [NSNumber(0), NSNumber(1)];
                gradientGenerator.isHorizontal = true
                gradientGenerator.dependencies.add(SFBlurImageMaker.lightEffect())
            }
            if let gradientGenerator = makers.filter({ $0 is SFColorImageMaker }).first as? SFColorImageMaker{
                gradientGenerator.dependencies.add(SFBlurImageMaker.lightEffect())
            }
        }
        cell.container.borderPosition = UIBorderPostion.init(borderResult)
        cell.container.reloadBackGourndImage()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RandomCell
//        let alert = UIAlertController.init(title: "DebugInfo", message: cell.container.debugInfo(), preferredStyle: .alert)
//        alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
