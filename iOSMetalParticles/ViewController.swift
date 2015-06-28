//
//  ViewController.swift
//  iOSMetalParticles
//
//  Created by Simon Gladman on 23/06/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParticleLabDelegate
{
    
    var gravityWellAngle: Float = 0
    var particleLab: ParticleLab!
    let floatPi = Float(M_PI)
    
    let fpsLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 400, height: 20))
    
    let imageSide = UInt(1024)
    
    let filterOneSegmentedControl = UISegmentedControl(items: ["gaussian", "sobel", "dilate", "erode", "median", "box", "tent"])
    let filterTwoSegmentedControl = UISegmentedControl(items: ["gaussian", "sobel", "dilate", "erode", "median", "box", "tent"])

    let segmentedControlsGroup = UIStackView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        particleLab = ParticleLab(width: imageSide, height: imageSide, numParticles: ParticleCount.TwoMillion)
        
        particleLab.dragFactor = 0.85
        particleLab.respawnOutOfBoundsParticles = true
        particleLab.particleLabDelegate = self
        
        view.addSubview(particleLab)
        
        fpsLabel.textColor = UIColor.blueColor()
        view.addSubview(fpsLabel)
        
        segmentedControlsGroup.addArrangedSubview(filterOneSegmentedControl)
        segmentedControlsGroup.addArrangedSubview(filterTwoSegmentedControl)
        segmentedControlsGroup.distribution = UIStackViewDistribution.EqualSpacing
        view.addSubview(segmentedControlsGroup)
        
        filterOneSegmentedControl.addTarget(self, action: "filterChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        filterTwoSegmentedControl.addTarget(self, action: "filterChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        
        filterOneSegmentedControl.selectedSegmentIndex = particleLab.filterIndexes.one
        filterTwoSegmentedControl.selectedSegmentIndex = particleLab.filterIndexes.two
    }
    
    func filterChangeHandler()
    {
       particleLab.filterIndexes = (filterOneSegmentedControl.selectedSegmentIndex, filterTwoSegmentedControl.selectedSegmentIndex)
    }
    
    func particleLabMetalUnavailable()
    {
        // handle metal unavailable here
    }
    
    func particleLabStatisticsDidUpdate(fps fps: Int, description: String)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            self.fpsLabel.text = description
        }
    }
    
    func particleLabDidUpdate()
    {
        cloudChamberStep()
    }
    
    func cloudChamberStep()
    {
        gravityWellAngle = gravityWellAngle + 0.02
        
        particleLab.setGravityWellProperties(gravityWell: .One,
            normalisedPositionX: 0.5 + 0.1 * sin(gravityWellAngle + floatPi * 0.5),
            normalisedPositionY: 0.5 + 0.1 * cos(gravityWellAngle + floatPi * 0.5),
            mass: 11 * sin(gravityWellAngle / 1.9),
            spin: 23 * cos(gravityWellAngle / 2.1))
        
        particleLab.setGravityWellProperties(gravityWell: .Four,
            normalisedPositionX: 0.5 + 0.1 * sin(gravityWellAngle + floatPi * 1.5),
            normalisedPositionY: 0.5 + 0.1 * cos(gravityWellAngle + floatPi * 1.5),
            mass: 11 * sin(gravityWellAngle / 1.9),
            spin: 23 * cos(gravityWellAngle / 2.1))
        
        particleLab.setGravityWellProperties(gravityWell: .Two,
            normalisedPositionX: 0.5 + (0.35 + sin(gravityWellAngle * 2.7)) * cos(gravityWellAngle / 1.3),
            normalisedPositionY: 0.5 + (0.35 + sin(gravityWellAngle * 2.7)) * sin(gravityWellAngle / 1.3),
            mass: 22 * cos(gravityWellAngle / 1.5),
            spin: -29 * sin(gravityWellAngle * 1.75))
        
        particleLab.setGravityWellProperties(gravityWell: .Three,
            normalisedPositionX: 0.5 + (0.35 + sin(gravityWellAngle * 2.7)) * cos(gravityWellAngle / 1.3 + floatPi),
            normalisedPositionY: 0.5 + (0.35 + sin(gravityWellAngle * 2.7)) * sin(gravityWellAngle / 1.3 + floatPi),
            mass: 22 * cos(gravityWellAngle / 1.5),
            spin: -29 * sin(gravityWellAngle * 1.75))
    }
 
    override func viewDidLayoutSubviews()
    {
        let qtrSide = CGFloat(imageSide / 4)
        let halfSide = CGFloat(imageSide / 2)
        
        particleLab.frame = CGRect(x: view.frame.width / 2 - qtrSide, y: view.frame.height / 2 - qtrSide, width: halfSide, height: halfSide)
        
        fpsLabel.frame =  CGRect(x: 10, y: topLayoutGuide.length, width: 400, height: 20)
        
        segmentedControlsGroup.frame = CGRect(x: 10, y: view.frame.height - filterOneSegmentedControl.intrinsicContentSize().height - 10, width: view.frame.width - 20, height: filterOneSegmentedControl.intrinsicContentSize().height)
    }
    
}

