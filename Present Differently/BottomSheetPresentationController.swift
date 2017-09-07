//
//  BottomSheetPresentationController.swift
//  Present Differently
//
//  Created by Sam Corder on 9/7/17.
//  Copyright © 2017 Synapptic Labs. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetPresentationController: UIPresentationController {
    fileprivate var dimmingView = UIView()
    fileprivate var sheetHeightPercentage: CGFloat

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, heightPercentage: CGFloat) {
        sheetHeightPercentage = heightPercentage
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }

    func setupDimmingView() {
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor(white: 0.50, alpha: 0.20)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }

    dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else { return }


        containerView.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))

        //Hack to get viewWillAppear & disappear to fire since the presentingViewController is not removed from the
        //view hierarchy
        presentingViewController.beginAppearanceTransition(false, animated: true)
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        }) { [presentingViewController] _ in
            presentingViewController.endAppearanceTransition()
        }
    }

    /// False by default.  The presenting view should stay in the hierarchy.
    override var shouldRemovePresentersView: Bool {
        return false
    }

    /// The final frame of the presented view controller
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        frame.origin.y = containerView.frame.height - frame.size.height
        return frame
    }

    /// The final size of the view controller
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * sheetHeightPercentage)
    }
}
