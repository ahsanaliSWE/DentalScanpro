# **Dental Cavities Detection App (DentalScan Pro)**

## **Project Overview**

**DentalScan Pro** is an innovative mobile application designed to detect and analyze dental cavities using advanced deep learning algorithms. This project aims to aid dental professionals and individuals in identifying dental issues early, promoting better oral health care through a user-friendly platform.

The app integrates cutting-edge models like **MobileNet V2**, **ResNet 50**, **EfficientDet D1**, and **YOLOv8** for accurate detection. It also includes features for storing patient data, sharing results, and viewing detailed cavity analysis.

---

## **Features**

- **AI-Powered Cavity Detection**: Identifies dental caries with high precision using deep learning models.
- **Real-Time Analysis**: Offers immediate results with bounding boxes indicating affected areas.
- **Multi-Model Integration**: Supports MobileNet V2, ResNet 50, EfficientDet D1, and YOLOv8, with YOLOv8 showing the best performance.
- **User-Friendly Interface**: A clean and intuitive design for ease of use by dentists and patients.
- **Data Management**: Saves previous detections and supports exporting data for professional use.

---

## **Technology Stack**

- **Mobile App Development**: Flutter  
- **Backend**: Firebase (Authentication, Firestore, Cloud Messaging)  
- **Deep Learning Models**: Trained using Python, TensorFlow, Keras, and Ultralytics  
- **Dataset**: Roboflow public dataset with 7,447 annotated dental images  
- **Training Environment**: Google Colab Pro (GPU/TPU acceleration)  
- **Visualization & UI Design**: Figma  

---

## **Key Results**

- **YOLOv8** achieved the highest detection accuracy and bounding box precision when implemented in the app.
- **ResNet 50** and **MobileNet V2** also performed well, but with slower detection times and occasional inaccuracies in bounding boxes.
- The app successfully integrates `.tflite` models for efficient mobile deployment.

| Model              | mAP@[IoU=0.50:0.95] | mAP@[IoU=0.50] | Average Recall | Total Loss |
|---------------------|---------------------|----------------|----------------|------------|
| **MobileNet V2**    | 0.433               | 0.646          | 0.544          | 0.243      |
| **ResNet 50**       | 0.436               | 0.670          | 0.550          | 0.251      |
| **EfficientDet D1** | 0.323               | 0.457          | 0.496          | 0.428      |
| **YOLOv8**          | 0.416               | 0.571          | 0.582          | 2.03       |

---

## **Screenshots**

### **1. Splash Screen**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Splash%20Screen.jpeg" alt="Login Screen" width="270" height="600"/>

### **2. Login Screen**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Login%20Screen.jpeg" alt="Login Screen" width="270" height="600"/>

### **3. Home Screen**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Home%20Screen.jpeg" alt="Home Screen" width="270" height="600"/>

### **4. Image Detection**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Image%20Detection.jpeg" alt="Image Detection" width="270" height="600"/>

### **5. Real-time Detection**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Real-time%20Detection.jpeg" alt="Real-time Detection" width="270" height="600"/>

### **6. Locate Doctor**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Locate%20Doctor.jpeg" alt="Locate Doctor" width="270" height="600"/>

### **7. Doctor Detail**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Doctor%20Detail.jpeg" alt="Doctor Detail" width="270" height="600"/>

### **8. Reminder Screen**
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Reminder%20Screen.jpeg" alt="Reminder Screen" width="270" height="600"/>

###

---

## **Demo Video**

📹 **Watch the App in Action**: [App Working Demo](video/demo.mp4)

https://github.com/user-attachments/assets/5cc820df-8b56-41c1-9306-73a3f670ad57



---

## **Group Members**

| **Name**              | **Roll Number**  | **Role**             |
|-----------------------|------------------|----------------------|
| *Ahsan Ali*           | 20SW135          | Developer/Researcher |
| *Hira Khuwaja*        | 20SW025          | Project Lead         |

---

## **Supervisor**

**Dr. Rabeea Jaffri**  
Department of Software Engineering  
Mehran University of Engineering and Technology 

## **Co-Supervisor**

**Dr. Shewar Javed**  


---

## **How to Run the Project**

### **Prerequisites**
1. Flutter SDK installed ([Download here](https://flutter.dev/docs/get-started/install)).
2. Android Studio or Visual Studio Code for development.
3. Firebase account with setup for authentication and Firestore.

### **Steps**
1. Clone the repository:
   ```bash
   git clone https://github.com/ahsanaliSWE/DentalScanpro.git
   cd DentalScanpro
