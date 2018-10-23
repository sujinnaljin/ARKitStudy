//
//  MultipleObjectsViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 23..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MultipleObjectsViewController: UIViewController, ARSCNViewDelegate {

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
    
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        
        let material = SCNMaterial()
        //material.diffuse.contents = UIColor.red
        material.diffuse.contents = UIImage(named : "brick.jpg")

        let node = SCNNode()
        node.geometry = box
        node.geometry?.materials = [material]
        node.position = SCNVector3(-0.1, 0.1, -0.5)
       
        //radius 단위도 meter
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIImage(named : "earth.jpg")
        
        let sphereNode = SCNNode(geometry : sphere)
        sphereNode.position = SCNVector3(0.5, 0.1, -1)
        
        scene.rootNode.addChildNode(node)
        scene.rootNode.addChildNode(sphereNode)
        
        
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
