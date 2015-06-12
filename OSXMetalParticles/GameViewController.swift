//
//  GameViewController.swift
//  OSXMetalParticles
//
//  Created by Simon Gladman on 12/06/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import Cocoa

class GameViewController : NSViewController
{
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        let particleLab = ParticleLab(width: 640, height: 480, numParticles: ParticleCount.FourMillion)
        
        view.addSubview(particleLab)
    }
    
}
