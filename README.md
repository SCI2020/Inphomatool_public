# Inphomatool —— A Calibration Scheme

This repository is a document describing the IQI software for confocal Non-Line-of-Sight (NLOS) calibration, which we call Inphomatool.

The principle of this software is introduced in paper “Onsite Non-line-of-sight Imaging via Online Calibration”

## ```Usage```
Inphomatool is based on MATLAB and LabVIEW, and the MATLAB appdesigner is required.

Inphomatool can calibrate the confocal NLOS system with Single Photon Avalanche Diode (SPAD), laser, galvanometer and other components.

## ```How to run```
Inphomatool has 4 modules, including Calibration, Measurements, Enhancements and Reconstruction. You should calibrate the system first, then measure and enhance data, and reconstruct with enhanced data.

**Before using Inphomatool, please make sure the connection between computer and the system components such as Laser, SPAD, galvo, delayer and so on, and then set ```global parameters```. All parameters should be in SI units. For example, if the repetition rate of laser is 40 MHz, set repetition rate as $4\times10^{7}$, and if the time bin of TCSPC is 4 ps, set time bin value as $4\times10^{-12}$**.

The calibration modules has 3 parts: galvanometer calibration, system jitter calibration, and relay wall calibration. Both galvanometer and jitter calibrations are one-click processing. (Galvanometer calibration is not open yet.) To execute relay wall calibration, please set the ```root``` as the absolute path of '/Inphomatool/resources' and the ```wall path``` as the absolute path of folder under 'Inphomatool/resources/wall/'.

The Auto measurement module can capture the transients data automatically, after set the required parameters. The Channel is the USB channel of delayer, Exposure is the exposure time per point (in millisecond). mode can be set as 'u' (uniform-grid) or 'mc' (multi-circles). In 'u' mode, X number and Y number are numbers of scan points in X and Y direction, and ‘scale’ is the side length (in meter); and in 'mc' mode, X number and Y number are numbers of scan points in radius and angle direction, and ‘scale’ is the diameter of the largest circle (in meter). X origin and Y origin are the X voltage and Y voltage of the scanning origin. Please set the ```wall path``` as the absolute path of folder under 'Inphomatool/resources/wall/', and the ```meas path``` as the absolute path of folder under 'Inphomatool/resources/meas/'.

The Enhancement moduld will enhance the measured transients. Please set the ```los path``` and ```nlos path``` as the absolute path of folder of los data and nlos data, which should be under 'Inphomatool/resources/meas/', and set the ```enhance path``` as the absolute path of folder under 'Inphomatool/resources/enhance/'.
The deGamma and denoise function are introduced in paper “Onsite Non-line-of-sight Imaging via Online Calibration”. We have prepared two data storage formats. If you want to reconstruct with our reconstruction module, please select the traditional one. For confocal data, Do **Not** select One shot mode. The enhanced data will be save as '```enhance path```/enhance_data.mat'.

The reconstruction module integrates the light-cone transform (LCT), f-k migration (fk) and phasor-field (PF) method to reconstruct the NLOS scene with the enhanced data. Please set the ```Code path``` as the absolute path of folder of 'Inphomatool/Package/recon/util', and the ```data path``` as the absolute path of folder of enhanced data, which should be under 'Inphomatool/resources/enhance/'

## ```Folder Name Explanation```
|Folder name| Explanation|
|:---:|:---:|
|Package|MATLAB source codes|
|VI|LabVIEW source codes|
|resources|folder for parameters & data|
|input|input voltages|
|output|output raw data|
|supplymentary|supplymentary document and data|
