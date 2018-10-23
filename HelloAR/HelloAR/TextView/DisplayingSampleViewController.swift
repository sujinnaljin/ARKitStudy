//
//  DisplayingSampleViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 23..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class DisplayingSampleViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame : self.view.frame)
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    
        let scene = SCNScene()
        //geometry for the text
        // extrusionDepth - depth of the text. so if I'm putting one over here basically the thing that the depth will be from minus 0.5 to positive 0.5.
        let textGeometry = SCNText(string: "hello world", extrusionDepth: 0)
        //바꾸지 않으면 defualt 는 white
        textGeometry.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        //너무 크게 나타나므로 .scale 속성 통해서 크기 조절
        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        scene.rootNode.addChildNode(textNode)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    

}
