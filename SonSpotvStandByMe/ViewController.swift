//
//  ViewController.swift
//  SonSpotvStandByMe
//
//  Created by Heo on 2023/03/15.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    @IBAction func openSetting(_ sender: Any) {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func sendPhoto(image: UIImage) {
        if MFMessageComposeViewController.canSendText() && MFMessageComposeViewController.canSendAttachments() {
            
            guard let phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.phoneNumber.keyName) else { return }
            
            let messageVC = MFMessageComposeViewController()
            messageVC.recipients = [phoneNumber]
            messageVC.messageComposeDelegate = self
            let imageData = image.jpegData(compressionQuality: 0.8)!
            messageVC.addAttachmentData(imageData, typeIdentifier: "public.image", filename: "photo.jpeg")
            present(messageVC, animated: true, completion: nil)
        } else {
            print("메시지를 보낼 수 없습니다.")
        }
    }
}


//MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            sendPhoto(image: image)
        }
    }
}


//MARK: - MFMessageComposeViewControllerDelegate
extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("취소")
        case .sent:
            print("전송 성공")
        case .failed:
            print("전송 실패")
        @unknown default:
            print("알 수 없는 결과")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
