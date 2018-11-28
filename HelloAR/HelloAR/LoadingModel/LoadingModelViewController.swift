//
//  LoadingModelViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 11. 28..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class LoadingModelViewController: UIViewController, ARSCNViewDelegate {

    var sceneView: ARSCNView!
    var planes = [OverlayPlane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: self.view.frame)
        view.addSubview(sceneView)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let mainScene = SCNScene()
        sceneView.scene = mainScene
        registerGestureRecognizers()
    }
    
    private func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
       // let doubleTappedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        //doubleTappedGestureRecognizer.numberOfTapsRequired = 2
        
       // tapGestureRecognizer.require(toFail: doubleTappedGestureRecognizer)
        
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
       // self.sceneView.addGestureRecognizer(doubleTappedGestureRecognizer)
    }
    
    @objc func tapped(recognizer :UIGestureRecognizer) {
        
        let sceneView = recognizer.view as! ARSCNView
        let touch = recognizer.location(in: sceneView)
      
        let hitResults = sceneView.hitTest(touch, types: .existingPlaneUsingExtent)

        if !hitResults.isEmpty {
            guard let hitResult = hitResults.first else {
                return
            }
            
            addHouse(hitResult: hitResult)
        }

    }
    private func addHouse(hitResult :ARHitTestResult) {
        
        
        // 물체들을 담고있는 새로운 씬 생성. 이때 named : 에는 .dae 경로를 작성
        let houseScene = SCNScene(named: "art.scnassets/house.dae")
        
        // 생성한 씬에서 나타내길 원하는 노드를 지정해줘야하는데 .dae파일에서 Scene graph 를 보면 SketchUp이 최상단에 위치해있음. 따라서 withName : 에 "SketchUp"을 써주면 .dae에 있는 모든 노드가 선택 될 것. 특정 노드만 선택하고 싶으면 "instance_0" 처럼 해당 이름을 써주면 됨. 이름은 변경 가능
        let houseNode = houseScene?.rootNode.childNode(withName: "SketchUp", recursively: true)
        ////  benchNode?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        //노드의 포지션을 정해줘야하는데 사용자가 터치한 위치에 따라 생성되게 할 것
        houseNode?.position = SCNVector3(hitResult.worldTransform.columns.3.x,hitResult.worldTransform.columns.3.y ,hitResult.worldTransform.columns.3.z)
        //스케일 조정 - width, height, depth를 원래 크기의 0.01 만큼으로 줄여줌
        houseNode?.scale = SCNVector3(0.01,0.01,0.01)

        //그리고 메인 씬에 추가해줌
        self.sceneView.scene.rootNode.addChildNode(houseNode!)
        //전체를 원할 때는 아래처럼 씬 자체를 추가해도 되는 듯
        //self.sceneView.scene = houseScene!
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !(anchor is ARPlaneAnchor) {
            return
        }
        let plane = OverlayPlane(anchor: anchor as! ARPlaneAnchor)
        self.planes.append(plane)
        node.addChildNode(plane)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
        }.first
        
        if plane == nil {
            return
        }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}
