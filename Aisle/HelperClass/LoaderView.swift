//
//  Loader.swift
//  Aisle
//
//  Created by GVM on 18/06/22.
//

import Foundation
import SVProgressHUD

enum snackBarType {
    case positive
    case negative
}

/// MARK: Loader View Enum
public enum LoadingViewStatus {
    case visible(text: String?)
    case error(text: String?)
    case show
    case hidden
    case hiddenWithDelay(_ delay: Double)
}

/// MARK: Loader View Protocol
public protocol LoaderViewPresentable {
    func setLoadingViewStatus(_ status: LoadingViewStatus)
}

/// MARK: Loader View Implementation

extension LoaderViewPresentable where Self: UIViewController {
    //
    public func setLoadingViewStatus(_ status: LoadingViewStatus) {
        defaultLoadingView(status)
    }
    
    private func defaultLoadingView(_ status: LoadingViewStatus) {
        if !isViewLoaded { return }
        
        // Decorate
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.clear) // Disable background interaction
        //
        switch status {
        case .show:
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.show()
        case .hidden:
            SVProgressHUD.dismiss()
        case .hiddenWithDelay(let delay):
            SVProgressHUD.dismiss(withDelay: delay)
        case  .error(let text):
            SVProgressHUD.showError(withStatus: text ?? NSLocalizedString("Failed", comment: ""))
            SVProgressHUD.dismiss(withDelay: 2.0)
        case .visible(let text):
            SVProgressHUD.show(withStatus: text ?? NSLocalizedString("Loading...", comment: ""))
        }
    }
}
