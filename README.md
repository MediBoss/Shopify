# Shopify

### Overview 

This repository contains the challenge code for the 2019 iOS Engineer Internship at Shopify. Repo should only be used by managers and recruiters @Shopify for assessment purposes.


### Screenshots

<img src= "Screenshots/home.png" width = 250 height = 500></img>
<img src= "Screenshots/detail.png" width = 250 height = 500></img>

### Getting Started

Run these commands to have the full project ready on your local machine.

`` git clone https://github.com/MediBoss/Shopify.git``

`` pod install ``

### File/Folder Architecture

I followed the MVC architecure for the Shopify challenge project. 
```
root/
|
|
|-- Shopify/                
        |-- Models                   # Contains all the models.
        |-- Views                    # Contains all UI cells. 
        |-- Controllers              # handles the connection between the the view, model, and networking.
        |-- Networking               # supports the networkinglayer.
        |-- Supporting Files         # contains extra files. 
        |-- Extensions               # conatains extension of current data types and classes.
        |-- Info.plist               # extra information about the application
|
|-- Screenshots/                     # images 
      | -- home.png
      | -- detail.png
      
|
|-- ShopifyTests/                    # Unit test set up
|
|-- ShopifyUITests/                  # UI Test set up
|
|                   
|-- README.md                          
|-- Podfile
|-- Podfile.lock
```

### Engineer
* **Medi Assumani** - *iOS Engineer*

### Built with

* Swift 4.2
* Xcode
* KingFisher
