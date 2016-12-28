//
//  PanelView.swift
//  WeiBoTest
//
//  Created by apple on 28/12/16.
//  Copyright © 2016年 mark. All rights reserved.
//  封装的版本
/*
  使用方法:
  外部创建
   lazy var panel:PanelView = PanelView()

   //设置视图位置，添加到view
   panel.center = view.center
 
   view.addSubview(panel)
 

*/
import UIKit

class PanelView: UIView {

    
    public lazy var progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /// 创建圆
        createCircle()
        
        /// 创建刻度
        createscale()
        
        /// 创建刻度值
        createCircleValue()
        
        /// 进度曲线
        createProgressLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 创建圆
    fileprivate func createCircle(){
        
        /// 创建圆
        let cicrle = UIBezierPath(arcCenter: center,
                                  radius: 100,
                                  startAngle: -(CGFloat(M_PI*9)/8),
                                  endAngle: (CGFloat(M_PI)/8),
                                  clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 10.0
        shapeLayer.lineCap = "round"
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor(colorLiteralRed: 185/255.0, green: 243/255.0, blue: 110/255.0, alpha: 1.0).cgColor
        shapeLayer.path = cicrle.cgPath
        
        self.layer.addSublayer(shapeLayer)
        
        
    }
    
    /// 创建刻度
    fileprivate func createscale(){
        
        /// 创建刻度
        
        let perAngle: CGFloat = CGFloat(M_PI*5)/4/50
        
        for i in 0...50 {
            
            let startAngle = -(CGFloat(M_PI*9)/8) + perAngle*CGFloat(i)
            let endAngle = startAngle + perAngle/5
            
            let tickPath = UIBezierPath(arcCenter: center,
                                        radius: 140,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
            
            let perLayer = CAShapeLayer()
            if i%5 == 0{
                print(i)
                perLayer.strokeColor = UIColor.orange.cgColor
                perLayer.lineWidth = 10.0
                
            }else{
                
                perLayer.strokeColor = UIColor.orange.cgColor
                perLayer.lineWidth = 5.0
            }
            
            perLayer.path = tickPath.cgPath
            
            self.layer.addSublayer(perLayer)
        }
        
    }
    
    /// 创建刻度值
    fileprivate func createCircleValue(){
        
        /// 创建刻度值
        
        let textAngle = Float(M_PI*5)/4/10
        
        for i in 0...10 {
            
            let point = calculateTextPositon(center,-Float(M_PI)/8+textAngle*Float(i))
            print(point)
            let tickString = "\(labs(10-i)*10)"
            
            let label = UILabel(frame: CGRect(x: point.x - 8, y: point.y - 7, width: 23, height: 14))
            label.text = tickString
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = UIColor.gray
            label.textAlignment = .center
            addSubview(label)
        }
    }
    
    /// 进度曲线
    fileprivate func createProgressLine(){
        
        /// 进度曲线
        let progressPath = UIBezierPath(arcCenter: center,
                                        radius: 120,
                                        startAngle: -(CGFloat(M_PI*9)/8),
                                        endAngle: (CGFloat(M_PI)/8),
                                        clockwise: true)
        progressLayer.lineWidth = 30.0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.cyan.cgColor
        progressLayer.path = progressPath.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0.5
        layer.addSublayer(progressLayer)
        
    }
    
    /// 计算文本的位置
    private func calculateTextPositon(_ ArcCenter: CGPoint,_ angle: Float) -> CGPoint{
        
        let x = 155 * cosf(angle)
        let y = 155 * sinf(angle)
        
        return CGPoint(x: ArcCenter.x + CGFloat(x), y: ArcCenter.y - CGFloat(y))
    }


}
