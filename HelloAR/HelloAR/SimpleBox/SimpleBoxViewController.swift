//
//  SimpleBoxViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 23..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SimpleBoxViewController: UIViewController, ARSCNViewDelegate {

    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame : self.view.frame)
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        // we will build a simple cube and we will try display that particular cube in the ar mode
        let scene = SCNScene()
        
        //box 에는 width, height, length, radius 의 속성 가짐
        //width, height, length are in metric (meter법)
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        
        //material is something that you can attach to your cube. and material can be an image and a material can also be a color
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        //important part => in scenekit all you gonna do is have nodes that represent a particular shape and on which different material has been applied
        //so in the end, it is the node that your adding in scenekit view
        let node = SCNNode()
        node.geometry = box
        node.geometry?.materials = [material]
        //we are working in a 3d space, so we will use vector
        //and have to provide x, y, z
        //x -> left or right / y ->higher /z -> how far you want to put this box. 얼마나멀리
        //meter 법
        node.position = SCNVector3(0, 0.1, -0.5)
        
        //finally I'm going to add the new node that I just created, the box node, which is loaded into my, as a child of the root node
        scene.rootNode.addChildNode(node)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        //이거 적용안해주면 현실 뷰 안보여줌
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    

}
