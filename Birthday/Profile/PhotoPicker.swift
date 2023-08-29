
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var selectedImage: UIImage?
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = context.coordinator
    return imagePicker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UIImagePickerControllerDelegate,
                     UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let selectedImage = info[.originalImage] as? UIImage {
        parent.selectedImage = selectedImage
      }
      picker.dismiss(animated: true,
                     completion: nil)
    }
    
  }
  
}


