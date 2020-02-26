//
//  ViewController.swift
//  RectangleMove
//
//  Created by 503 on 2020/02/25.
//  Copyright © 2020 ssang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url = [
            "img1.jpg",
            "img2.jpg",
            "img3.jpg",
            "img4.jpg",
            "img5.png",
            "img6.jpg",
            "img7.jpg",
            "img8.jpg",
            "img9.jpg",
            "img10.jpg",
            "img11.jpg",
            "img12.jpg" ]
    
    // 이미지 뷰를 담아놓을 배열
    var imgViewArray:Array = Array<UIImageView>()
    var pointer:UIView!
    var targetX:CGFloat=0
    var targetY:CGFloat=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createImage()
        createPointer()
        //게임의 엔진에 해당하는 루프실행'//사실상 모든 애니메이션이 가동하려면 루프가 존재해야함'
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(move), userInfo: nil, repeats: true)
    }
     //이미지 썸네일 동적 생성
    func createImage(){
        var index:Int=0 //배열접근인덱스
        
        for a in 1...3{
            for i in 1...4{
                let mv = UIImageView(image:UIImage(named: url[index]))
                //나중에 이미지뷰를 제어하기 위해 배열에 보관해 놓자
                imgViewArray.append(mv)
                mv.frame = CGRect(x: 82*i, y: 82*a, width: 80,height: 80)
                self.view.addSubview(mv)
                
                index = index + 1
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(getPos))
                mv.addGestureRecognizer(gesture)
                mv.isUserInteractionEnabled = true
            }
        }
    }
    //포인터 생성하기 '
    func createPointer(){
        //첫번/재 이미지뷰의 좌표를 초기위치로 할당하자
        let posX = imgViewArray[0].frame.origin.x
        let posY = imgViewArray[0].frame.origin.y
        
        pointer = UIView(frame: CGRect(x: posX, y: posY, width: 80, height: 80))
        pointer.backgroundColor = UIColor.red
        pointer.alpha = 0.5
        
        //포인터의 초기 위치 설정
        targetX = posX
        targetY = posY
        //view에 부착
        self.view.addSubview(pointer)
        
    }
    
    
    @objc func getPos(sender:UITapGestureRecognizer){
        //지금 터치한 뷰의 좌표 얻기
        let imgView = sender.view as? UIImageView
        targetX = imgView!.frame.origin.x
        targetY = imgView!.frame.origin.y
        
        
        
    }
    
    @objc func move(){
        //포인터의 위치 지정 '
        pointer.frame.origin.x = pointer.frame.origin.x +
            0.1*(targetX - pointer.frame.origin.x)
        pointer.frame.origin.y = pointer.frame.origin.y +
            0.1*(targetY - pointer.frame.origin.y)
    }
}

