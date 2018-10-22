//
//  ViewController.swift
//  HelloAR
//
//  Created by 강수진 on 2018. 10. 23..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

//ARSCNViewDelegate is delegate that will be responsible for anything that is going in the field
//if you are adding elements or you removing elements or any two of the elements you need to use this ARSCNViewDelegate(argumented reality scene view delegate)
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // where we are setting the configuration for our scene to run our session for that particular scene.
        //This means that the our application will be capable of world tracking. this means that I can go near the plane and it will have all those kind of 3D plus 4D effect
        //if I want to limit some of the effects like in older devices which are older than iPhone 6,  then you can use ARSession configuration.
        //You have to ARWorldTrackingConfiguration which takes into account that you are running on iPhone 6 or higher and that's pretty much what is needed to create your basic level of augmented reality application.
        // Create a session configuration
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
