//
//  JKCircleProgressView.swift
//  SwiftyExtension
//
//  Created by 王冲 on 2022/12/8.
//
import AppKit

public class JKCircleProgressView: NSView {
    // MARK: - Properties
    public var lineWidth: CGFloat = 10 {
        didSet {
            updatePath()
        }
    }

    public var trackColor = NSColor(calibratedRed: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1) {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    public var progressColor = NSColor.orange {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    public var progress: Int {
        get { return currentProgress }
        set { setProgress(newValue, animated: false) }
    }

    private var currentProgress: Int = 0

    // MARK: - Layers
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    // MARK: - Initialization
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }

    // MARK: - Layer Setup
    private func setupLayers() {
        // 设置进度槽
        trackLayer.fillColor = NSColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.lineCap = .round
        self.layer = CALayer() // 确保有 layer
        self.wantsLayer = true
        layer?.addSublayer(trackLayer)

        // 设置进度条
        progressLayer.fillColor = NSColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        layer?.addSublayer(progressLayer)

        updatePath()
    }

    // MARK: - Path Update
    private func updatePath() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.size.width, bounds.size.height) / 2 - lineWidth / 2
        let path = NSBezierPath()
        path.appendArc(withCenter: center, radius: radius, startAngle: -90, endAngle: 270, clockwise: false)
        let cgPath = path.cgPath
        trackLayer.path = cgPath
        trackLayer.lineWidth = lineWidth
        progressLayer.path = cgPath
        progressLayer.lineWidth = lineWidth
    }

    // MARK: - Progress Update
    public func setProgress(_ pro: Int, animated anim: Bool = false, withDuration duration: Double = 0.5) {
        currentProgress = max(0, min(pro, 100))

        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(currentProgress) / 100.0
        CATransaction.commit()
    }

    // MARK: - Layout
    public override func layout() {
        super.layout()
        updatePath()
    }
}

// MARK: - NSBezierPath to CGPath helper
private extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [NSPoint](repeating: .zero, count: 3)
        for i in 0..<elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                break
            }
        }
        return path
    }
}
