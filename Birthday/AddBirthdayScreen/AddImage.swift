
import SwiftUI

struct AddImage: UIViewControllerRepresentable {
  
  @Binding var addImage: UIImage?
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = context.coordinator
    return imagePicker
  }
  
  func updateUIViewController(
    _ uiViewController: UIImagePickerController,
    context: Context
  ) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject,
  UINavigationControllerDelegate,
  UIImagePickerControllerDelegate {
    
    var parent2: AddImage
    
    init(_ parent: AddImage) {
      self.parent2 = parent
    }
    
    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [
        UIImagePickerController.InfoKey: Any
      ]
    ) {
      if let selectedImage = info[.originalImage] as? UIImage {
        parent2.addImage = selectedImage
      }
      picker.dismiss(
        animated: true,
        completion: nil
      )
    }
    
  }
  
}
