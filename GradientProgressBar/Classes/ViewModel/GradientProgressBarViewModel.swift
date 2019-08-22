//
//  GradientProgressBarViewModel.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01/20/18.
//  Copyright © 2018 Felix Mau. All rights reserved.
//

import Foundation
import LightweightObservable

/// This view model keeps track of the progress-value and updates the `alphaLayerFrame` accordingly.
class GradientProgressBarViewModel {
    // MARK: - Config

    /// Default animation duration for call to `setProgress(x, animated: true)`.
    ///
    /// - Note: Equals to `CALayer` default animation duration (https://apple.co/2PVTCsB).
    static let defaultAnimationDuration = 0.25

    /// Default animation timing function for animated progress change.
    static let defaultTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

    // MARK: - Types

    /// Combines all properties for an animated update of a frame.
    struct FrameAnimation: Equatable {
        /// Initializes the struct with all values set to zero.
        static let zero = FrameAnimation(frame: .zero,
                                         duration: 0.0)

        /// The new rect for the frame.
        let frame: CGRect

        /// The animation duration to update the frame with.
        let duration: TimeInterval
    }

    // MARK: - Public properties

    /// The frame for the alpha layer.
    var maskLayerFrameAnimation: Observable<FrameAnimation> {
        return maskLayerFrameAnimationSubject.asObservable
    }

    /// The current bounds of the progress view.
    var bounds: CGRect = .zero {
        didSet {
            let didChange = bounds != oldValue
            guard didChange else {
                // Prevent unnecessary UI-updates.
                return
            }

            maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimationForCurrentProgress(animated: false)
        }
    }

    /// The current progress.
    var progress: Float = 0.5 {
        didSet {
            guard shouldUpdateMaskLayerFrameOnProgressChange else { return }

            maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimationForCurrentProgress(animated: false)
        }
    }

    /// Animation duration for animated progress change.
    var animationDuration = GradientProgressBarViewModel.defaultAnimationDuration

    /// Animation timing function for animated progress change.
    var timingFunction = GradientProgressBarViewModel.defaultTimingFunction

    // MARK: - Private properties

    private let maskLayerFrameAnimationSubject: Variable<FrameAnimation> = Variable(.zero)

    /// Boolean flag whether we should calculate a new frame for the mask-layer
    /// on setting the `progress` value.
    ///
    /// - SeeAlso: `setProgress(_:animated:)`
    private var shouldUpdateMaskLayerFrameOnProgressChange = true
    // swiftlint:disable:previous identifier_name

    // MARK: - Public methods

    /// Adjusts the current progress, optionally animating the change.
    func setProgress(_ progress: Float, animated: Bool = false) {
        // We don't want to update the mask-layer frame on setting the progress value,
        // as we might have to do it animated.
        shouldUpdateMaskLayerFrameOnProgressChange = false
        self.progress = progress
        shouldUpdateMaskLayerFrameOnProgressChange = true

        maskLayerFrameAnimationSubject.value = makeMaskLayerFrameAnimationForCurrentProgress(animated: animated)
    }

    // MARK: - Private methods

    private func makeMaskLayerFrameAnimationForCurrentProgress(animated: Bool) -> FrameAnimation {
        var maskLayerFrame = bounds
        maskLayerFrame.size.width *= CGFloat(progress)

        let animationDuration: TimeInterval
        if animated {
            animationDuration = self.animationDuration
        } else {
            animationDuration = 0.0
        }

        return FrameAnimation(frame: maskLayerFrame,
                              duration: animationDuration)
    }
}
