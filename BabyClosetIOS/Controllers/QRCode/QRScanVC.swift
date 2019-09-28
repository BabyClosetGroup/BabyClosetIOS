//
//  QRScanVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 20/09/2019.
//  Copyright © 2019 박경선. All rights reserved.


import UIKit
import AVFoundation

class QRScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet var videoPreview: UIView!

    var stringURL: String = ""
    enum error: Error {
        case noCameraAvailable
        case videoInputInitFail
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar()
        do {
            try scanQRCode()
        } catch {
            print("Failed to scan the QR")
        }

    }
    func showToast() {
        let label = UILabel(frame: CGRect(x: 54, y: 668, width: 267, height: 51))
        label.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 0.47)
        label.textColor = UIColor.white
        label.textAlignment = .center
        view.addSubview(label)
        label.text = "나눔 인증되었습니다"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.alpha = 1
        label.layer.cornerRadius = 26;
        label.clipsToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1.0, animations: {
                label.alpha = 0
            }, completion: {
                (isBool) -> Void in
                self.dismiss(animated: true, completion: nil)
                
            })
        }
    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)

        self.navigationItem.title = "QR인증하기"

    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                print(machineReadableCode.stringValue!)
                if let qrValue = machineReadableCode.stringValue {
                    self.handleQRRead(value: qrValue)
                }
                performSegue(withIdentifier: "openLink", sender: self)
            }
        }
    }
    func handleQRRead(value: String) {
        print(value)
        showToast()
    }
    func  scanQRCode() throws {
        let avCaptureSession = AVCaptureSession()

        guard let avCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("No camera")
            throw error.noCameraAvailable
        }
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to init Camera.")
            throw error.videoInputInitFail
        }

        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)

        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)

        avCaptureSession.startRunning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "openLink" {
//            let destination = segue.destination as! WebViewController
//            destination.url = URL(string: stringURL)
//        }
    }
}

