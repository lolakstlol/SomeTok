//
//  CameraViewController.swift
//  AVFoundationSwift
//
//  Created by Rubaiyat Jahan Mumu on 7/15/19.
//  Copyright © 2019 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit
import Photos

enum PostType {
    case ad
    case nonAd
}

class CameraViewController: UIViewController {
    func onSuccess(model: UploadResponse) {
        print(model)
    }
    
    func onFailed() {
        print("hyevo")
    }
    
    @IBOutlet weak var cameraContainer: UIView!
    @IBOutlet weak var switcherContainer: UIView!
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var toggleCameraButton: UIButton!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var materialButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraSelectionButton: UIButton!
    @IBOutlet weak var videoCameraButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    
    var cameraConfig: CameraConfiguration!
    let imagePickerController = UIImagePickerController()
    private var selectedPostType: PostType = .ad
    
    var videoRecordingStarted: Bool = false {
        didSet{
            if videoRecordingStarted {
                self.cameraButton.backgroundColor = UIColor.red
            } else {
                self.cameraButton.backgroundColor = UIColor.white
            }
        }
    }
    
    func checkPermission(completion: @escaping ()->Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            completion()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    completion()
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        case .limited:
            // same same
            print("SUCK")
        }
    }
    
    fileprivate func registerNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: NSNotification.Name(rawValue: "App is going background"), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @IBAction func backCameraButton(_ sender: Any) {
        guard let tabbar = tabBarController as? TabBarViewController else { return }
        tabbar.tabBar.isHidden = false
        tabbar.returnToPreviositem()
    }
    
    @objc func appMovedToBackground() {
        if videoRecordingStarted {
            videoRecordingStarted = false
            self.cameraConfig.stopRecording { (error) in
                print(error ?? "Video recording error")
            }
        }
    }
    
    @IBAction func gotoGallery(_ sender: Any) {
        DispatchQueue.main.async {
            self.checkPermission(completion: {
                self.imagePickerController.sourceType = .photoLibrary
                self.imagePickerController.delegate = self
                
                self.imagePickerController.mediaTypes = ["public.image", "public.movie"]
                self.present(self.imagePickerController, animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func secondButtonDidTap(_ sender: Any) {
        configure(withType: .nonAd)
    }
    
    @IBAction func firstButtonDidTap(_ sender: Any) {
        configure(withType: .ad)
    }
    
    @objc func appCameToForeground() {
        print("app enters foreground")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraConfig = CameraConfiguration()
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            try? self.cameraConfig.displayPreview(self.previewImageView)
            self.cameraConfig.outputType = .video
        }
        self.cameraButton.tintColor = UIColor.black
        registerNotification()
        
        firstButton.setTitle(Strings.Camera.Publication.ad, for: .normal)
        materialButton.setTitle(Strings.Camera.Publication.nonad, for: .normal)
        materialButton.layer.cornerRadius = 14
        firstButton.layer.cornerRadius = 14
        switcherContainer.layer.cornerRadius = 17
        cameraContainer.layer.cornerRadius = 35
        configure(withType: selectedPostType)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func toggleFlash(_ sender: Any) {
        if cameraConfig.flashMode == .on {
            cameraConfig.flashMode = .off
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "Light"), for: .normal)
        } else if cameraConfig.flashMode == .off {
            cameraConfig.flashMode = .on
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "Light_off"), for: .normal)
        } else {
            cameraConfig.flashMode = .auto
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "Light"), for: .normal)
        }
    }
    
    func uploadVideoFlow(video: Data, preview: UIImage) {
        switch selectedPostType {
        case .ad:
            return
        case .nonAd:
            guard let data = preview.jpegData(compressionQuality: 1) else { return }
            let vc = CreatePrivatePostAssembler.createModule(video: video, preview: data)
            navigationController?.pushViewController(vc, animated: true)
        }
        return
    }
    
    @objc fileprivate func showToastForSaved() {
        showToast(message: "Saved!", fontSize: 12.0)
    }
    
    @objc fileprivate func showToastForRecordingStopped() {
        showToast(message: "Recording Stopped", fontSize: 12.0)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            showToast(message: "Saved", fontSize: 12.0)
            self.galleryButton.setImage(image, for: .normal)
        }
    }
    
    @objc func video(_ video: String, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            showToast(message: "Saved", fontSize: 12.0)
        }
        print(video)
    }
    
    private func showImagePicker() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie", "public.image"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnTakePhotoButton(_ sender: Any) {
        if self.cameraConfig.outputType == .photo {
            self.cameraConfig.captureImage { (image, error) in
                guard let image = image else {
                    
                    print(error ?? "Image capture error")
                    return
                }
                self.previewImageView.image = image
//                try? PHPhotoLibrary.shared().performChangesAndWait {
//                    PHAssetChangeRequest.creationRequestForAsset(from: image)
//                }
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else {
            if videoRecordingStarted {
                videoRecordingStarted = false
                self.cameraConfig.stopRecording { (error) in
                    print(error ?? "Video recording error")
                }
            } else if !videoRecordingStarted {
                videoRecordingStarted = true
                self.cameraConfig.recordVideo { (url, error) in
                    if let data = try? self.cameraConfig.rearCamera?.lockForConfiguration() {
                        self.cameraConfig.rearCamera?.torchMode = .off
                        self.cameraConfig.rearCamera?.unlockForConfiguration()
                    }
                    guard let url = url else {
                        print(error ?? "Video recording error")
                        return
                    }
                    if let data = try? Data(contentsOf: url) {
                        CameraApiWorker.encodeVideo(at: url) { data, error in
                            DispatchQueue.main.async {
                                self.uploadVideoFlow(video: data!, preview: self.videoSnapshot(vidURL: url)!)
                            }
                        }
                    }
                    UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(self.video(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }
    }
    
    func videoSnapshot(vidURL: URL) -> UIImage? {

        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true

        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)

        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
    
    func configure(withType: PostType) {
        UIView.animate(withDuration: 0.3) {
            switch withType {
            case .ad:
                self.firstButton.setTitleColor(.white, for: .normal)
                self.firstButton.backgroundColor = Assets.mainRed.color
                self.materialButton.setTitleColor(Assets.darkGrayText.color, for: .normal)
                self.materialButton.backgroundColor = .clear
            case .nonAd:
                self.materialButton.setTitleColor(.white, for: .normal)
                self.materialButton.backgroundColor = Assets.mainRed.color
                self.firstButton.setTitleColor(Assets.darkGrayText.color, for: .normal)
                self.firstButton.backgroundColor = .clear
            }
        }
        selectedPostType = withType
    }
    
    
    @IBAction func toggleCamera(_ sender: Any) {
        do {
            try cameraConfig.switchCameras()
        } catch {
            print(error.localizedDescription)
        }
        
//        switch cameraConfig.currentCameraPosition {
//        case .some(.front):
//            self.toggleCameraButton.setImage(#imageLiteral(resourceName: "camera_front"), for: .normal)
//        case .some(.rear):
//            self.toggleCameraButton.setImage(#imageLiteral(resourceName: "camera_rear"), for: .normal)
//        default:
//            return
//        }
    }
    @IBAction func selectVideoMode(_ sender: Any) {
        self.cameraConfig.outputType = .video
        self.cameraButton.setImage(#imageLiteral(resourceName: "videocam"), for: .normal)
    }
    @IBAction func selectCameraMode(_ sender: Any) {
        self.cameraConfig.outputType = .photo
        self.cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
    }
    
}

//Disabling Xcode’s OS-Level Debug Logging
//1- From Xcode menu open: Product > Scheme > Edit Scheme
//2- On your Environment Variables set OS_ACTIVITY_MODE in the value set disable
// this will stop the warning but not the error

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.galleryButton.contentMode = .scaleAspectFit
            self.galleryButton.setImage( pickedImage, for: .normal)
        }
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            print("videoURL:\(String(describing: videoURL))")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
