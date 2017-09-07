//
//  ViewController.swift
//  Present Differently
//
//  Created by Sam Corder on 9/6/17.
//  Copyright © 2017 Synapptic Labs. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBAction func presentModal(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "modal") else { return }

        //Setup the presentation to use our delegate
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self

        present(vc, animated: true, completion: nil)
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }

}

//Transitioning Delegate that vends out the presentation controller and animation delegates.
extension RootViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BottomSheetPresentationController(presentedViewController: presented,
                                                                           presenting: presenting,
                                                                           heightPercentage: 0.5)
        return presentationController
    }
}
