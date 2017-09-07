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

        present(vc, animated: true, completion: nil)
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }

}

