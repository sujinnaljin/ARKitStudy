//
//  OverlayingPlanesViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 30..
//  Copyright © 2018년 강수진. All rights reserved.
//


//enum BodyType : Int {
//    case box = 1
//    case plane = 2
//    case car = 3
//}

import UIKit
import SceneKit
import ARKit

class OverlayingPlanesViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    var planes = [OverlayPlane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView = ARSCNView(frame : self.view.frame)
        self.view.addSubview(sceneView)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
