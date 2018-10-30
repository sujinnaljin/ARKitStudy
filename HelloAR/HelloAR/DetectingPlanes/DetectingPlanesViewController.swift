//
//  DetectingPlanesViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 30..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class DetectingPlanesViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    //label 추가해서 평면이 인식되면 이 label 이 나타나게 할것
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView = ARSCNView(frame : self.view.frame)
        self.view.addSubview(sceneView)
        
        self.label.frame = CGRect(x: 0, y: 0, width: self.sceneView.frame.size.width, height: 44)
        self.label.center = self.sceneView.center
        self.label.textAlignment = .center
        self.label.textColor = UIColor.white
        self.label.font = UIFont.preferredFont(forTextStyle: .headline)
        self.label.alpha = 0
        
        self.sceneView.addSubview(self.label)
       
        
        //sceneView에 디버깅 옵션을 달아줌
        //showFeaturePoints -> 얼마나 많은 특징점 (feature points)들이 존재하는지
        //showWorldOrigin -> x, y, z 좌표가 현실에 떠있는 것처럼 볼 수 있음.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
       
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        //해당 줄을 추가하면 수평면을 인식했을때 알려줌 , vertical 은 없음
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            self.label.text = "plane detected!"
            UIView.animate(withDuration: 3.0, animations: {
                self.label.alpha = 1.0
            }, completion: { (_) in
                self.label.alpha = 0.0
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}

