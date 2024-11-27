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
<img src="https://github.com/ahsanaliSWE/DentalScanpro/blob/main/screenshots/Login%20Screen.jpeg" alt="Login Screen" width="500" height="300"/>


### **2. Login Screen**

### **3. Home Screen**
![Home Screen](screenshots/home_screen.png)

### **2. Detection Screen**
![Detection Screen](screenshots/detection_screen.png)

### **3. Analysis Result**
![Result Analysis](screenshots/analysis_screen.png)

###

---

## **Demo Video**

📹 **Watch the App in Action**: [App Working Demo](video/demo.mp4)

---

## **Group Members**

| **Name**             | **Role**                 | 
|-----------------------|--------------------------|
| *Your Name*           | Developer/Researcher    |
| *Teammate Name*       | Co-Developer/Researcher |

---

## **Supervisor**

**Dr. Yasmeen Naz Panhwar**  
Department of Software Engineering  
[Your University Name]  

---

## **How to Run the Project**

### **Prerequisites**
1. Flutter SDK installed ([Download here](https://flutter.dev/docs/get-started/install)).
2. Android Studio or Visual Studio Code for development.
3. Firebase account with setup for authentication and Firestore.

### **Steps**
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/dental-scan-pro.git
   cd dental-scan-pro
