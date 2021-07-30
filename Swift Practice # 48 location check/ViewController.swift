//
//  ViewController.swift
//  Swift Practice # 48 location check
//
//  Created by CHEN PEIHAO on 2021/7/30.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //十進位DD經緯度TextField
    @IBOutlet weak var DDOfLatitude: UITextField!
    @IBOutlet weak var DDOfLongtude: UITextField!
    
    //經緯度分DDM經緯度TextField
    @IBOutlet weak var DDMOfLatiude: UITextField!//度
    @IBOutlet weak var DDMOfLongitude: UITextField!
    @IBOutlet weak var DDMOfMinuteLatitude: UITextField!//分
    @IBOutlet weak var DDMOfMinuteLongitude: UITextField!
    
    //經緯度分秒DMS經緯度TextField
    @IBOutlet weak var DMSOfLatitude: UITextField!//度
    @IBOutlet weak var DMSOfLongitude: UITextField!
    @IBOutlet weak var DMSOfMinuteLatitude: UITextField!//分
    @IBOutlet weak var DMSOfMintueLongitude: UITextField!
    @IBOutlet weak var DMSOfSecondLattude: UITextField!//秒
    @IBOutlet weak var DMSOfSecondLongitude: UITextField!
    
    
    //標記的TextField跟MKMap
    @IBOutlet weak var MarkTextField: UITextField!
    @IBOutlet weak var MapMKMapView: MKMapView!
    
    
    //任意螢幕收鍵盤
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.endEditing(true)
        // Do any additional setup after loading the view.
    }
    
    //定義輸入經緯度顯示地圖位置的function
    func ShowTheMap (Latitude:Double, Longitude:Double ) {
        MapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude),latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    //DD十進位換算按鈕
    @IBAction func DDConvertDMMAndDMS(_ sender: UIButton) {
        //收鍵盤
        view.endEditing(true)
        //先將DD經緯度從字串換成浮點數，並輸入？？optional確定有無輸入
        let Latitude = Double(String(DDOfLatitude.text ?? ""))
        let Longitude = Double(String(DDOfLongtude.text ?? ""))
        //取出DD經緯度的整數值，從浮點數轉整數，並透過optional判斷
        let intOfLatitude = Int(Latitude ?? 0.0)
        let intOfLongitude = Int(Longitude ?? 0.0)
        
        //DD轉DMM區域
        //DMM第一個數字就是DD的整數，故直接使用取出來的數字
        DDMOfLatiude.text = "\(intOfLatitude)"
        DDMOfLongitude.text = "\(intOfLongitude)"
        //DDM的第二個數字，透過公式透過小數點*60取得
        let contentOfDMMOfMinuteLatiute = ((Latitude ?? 0.0) - Double(intOfLatitude)) * 60
        let contentOfDMMOfMinuteLongitute = ((Longitude ?? 0.0) - Double(intOfLongitude)) * 60
        DDMOfMinuteLatitude.text = String(format: "%.6f", contentOfDMMOfMinuteLatiute)
        DDMOfMinuteLongitude.text = String(format: "%.6f", contentOfDMMOfMinuteLongitute)
        
        //DD轉DMS的區域
        //第一個數字
        DMSOfLatitude.text = "\(intOfLatitude)"
        DMSOfLongitude.text = "\(intOfLongitude)"
        //第二個數字為DMM第二個值的整數
        let contentOfDMSMinuteLatiute = Int(contentOfDMMOfMinuteLatiute)
        let contentOfDMSMinuteLongitude = Int(contentOfDMMOfMinuteLongitute)
        DMSOfMinuteLatitude.text = "\(contentOfDMSMinuteLatiute)"
        DMSOfMintueLongitude.text = "\(contentOfDMSMinuteLongitude)"
        //第三個數字為第二個數字小數點*60取得
        let contentOfDMSSecondLatitude = (contentOfDMMOfMinuteLatiute - Double(contentOfDMSMinuteLatiute)) * 60
        let contentOfDMSSecondLongitude = (contentOfDMMOfMinuteLongitute - Double(contentOfDMSMinuteLongitude)) * 60
        DMSOfSecondLattude.text = String(format: "%.6f", contentOfDMSSecondLatitude)
        DMSOfSecondLongitude.text = String(format: "%.6f", contentOfDMSSecondLongitude)
        
        //地圖顯示輸入的經緯度位置
        ShowTheMap(Latitude: (Latitude ?? 0.0), Longitude: (Longitude ?? 0.0))
        
    }
    
    
    @IBAction func DMMConvertToDDAndDMS(_ sender: UIButton) {
        view.endEditing(true)
        //先將DMM四的TexfField輸入的值轉型
        let DOfDMMLatitude = Double(String(DDMOfLatiude.text ?? ""))//緯度取值
        let DOfDMMLongitude = Double(String(DDMOfLongitude.text ?? ""))//經度取值
        let MOfDMMLatitude = Double(String(DDMOfMinuteLatitude.text ?? ""))//緯分取值
        let MOfDMMLongitude = Double(String(DDMOfMinuteLongitude.text ?? ""))//經分取值

        //DMS的轉換區域
        DMSOfLatitude.text = "\(Int(DOfDMMLatitude ?? 0.0))"//緯度顯示
        DMSOfLongitude.text = "\(Int(DOfDMMLongitude ?? 0.0))"//精度顯示
        let intDMSOfMLatitude = Int(MOfDMMLatitude ?? 0.0)//浮點轉型整數
        let intDMSOfMLongitude = Int(MOfDMMLongitude ?? 0.0)//浮點轉型整數
        DMSOfMinuteLatitude.text = "\(intDMSOfMLatitude)"//緯分顯示
        DMSOfMintueLongitude.text = "\(intDMSOfMLongitude)"//經分顯示
        let sOfDMSLatitude = ((MOfDMMLatitude ?? 0.0) - Double(intDMSOfMLatitude)) * 60 //公式取緯秒的值
        let sOfDMSlongitude = ((MOfDMMLongitude ?? 0.0) - Double(intDMSOfMLongitude)) * 60 //公式取經秒的值
        DMSOfSecondLattude.text = String(format: "%.4f", sOfDMSLatitude)//緯秒顯示
        DMSOfSecondLongitude.text = String(format: "%.4f", sOfDMSlongitude)//經秒顯示
        
        //DD十進位的轉換區域
        let Latitude = (DOfDMMLatitude ?? 0.0) + ((MOfDMMLatitude ?? 0.0) / 60) //公式取值
        let Longtiude = (DOfDMMLongitude ?? 0.0) + ((MOfDMMLongitude ?? 0.0) / 60) //公式取值
        DDOfLatitude.text = String(format: "%.6f", Latitude)//十進位緯度
        DDOfLongtude.text = String(format: "%.6f", Longtiude)//十進位經度
        
        ShowTheMap(Latitude: (Latitude ?? 0.0 ), Longitude: (Longtiude ?? 0.0))
    }
    
    
    @IBAction func DMSConverToDMMAndDD(_ sender: UIButton) {
        
        view.endEditing(true)
        //取六個TextField的值
        let DOfDMSLatitude = Double(String(DMSOfLatitude.text ?? ""))
        let DOfDMSLongitude = Double(String(DMSOfLongitude.text ?? ""))
        let MOfDMSLatitude = Double(String(DMSOfMinuteLatitude.text ?? ""))
        let MOfDMSLongitude = Double(String(DMSOfMintueLongitude.text ?? ""))
        let SOfDMSLatitude = Double(String(DMSOfSecondLattude.text ?? ""))
        let SOfDMSLongitude = Double(String(DMSOfSecondLongitude.text ?? ""))
        
        //DMM轉換區域
        DDMOfLatiude.text = "\(Int(DOfDMSLatitude ?? 0.0))"//DMM緯度顯示
        DDMOfLongitude.text = "\(Int(DOfDMSLongitude ?? 0.0))"//DMM經度顯示
        let mOfDMMLatitude = (MOfDMSLatitude ?? 0.0) + ((SOfDMSLatitude ?? 0.0) / 60) //公式取值後指派
        let mOfDMMLongitude = (MOfDMSLongitude ?? 0.0) + ((SOfDMSLongitude ?? 0.0) / 60) //公式取值後指派
        DDMOfMinuteLatitude.text = String(format: "%.4f", mOfDMMLatitude)//緯分的值顯示
        DDMOfMinuteLongitude.text = String(format: "%.4f", mOfDMMLongitude)//經分的值顯示
        
        //DD區域轉換
        let Latitude =  (DOfDMSLatitude ?? 0.0) + ((MOfDMSLatitude ?? 0.0) / 60) + ((SOfDMSLatitude ?? 0.0) / 3600) //公式換算取緯度值
        let longitde = (DOfDMSLongitude ?? 0.0) + ((MOfDMSLongitude ?? 0.0) / 60) + ((SOfDMSLongitude ?? 0.0) / 3600) //公式換算取經度值
        DDOfLatitude.text = String(format: "%.6f", Latitude)//緯度顯示內容
        DDOfLongtude.text = String(format: "%.6f", longitde)//經度顯示內容
        
        ShowTheMap(Latitude: (Latitude ?? 0.0), Longitude: (longitde ?? 0.0))
    }
    
    //地圖標記Button
    @IBAction func remarkTheTitle(_ sender: UIButton) {
        view.endEditing(true)
        let Latitude = Double(String(DDOfLatitude.text ?? ""))//取值
        let Longitude = Double(String(DDOfLongtude.text ?? ""))//取值
        
        let markPoint = MKPointAnnotation() //引用MKPointAnnotation()後指派
        markPoint.title = MarkTextField.text // 標記TextField內的值成為地圖標記的title
        markPoint.coordinate = CLLocationCoordinate2D(latitude: (Latitude ?? 0.0), longitude: (Longitude ?? 0.0))
        MapMKMapView.addAnnotation(markPoint)//指定完內容加入到MapMKMapView內
    }
    
    //清除所有按鈕
    @IBAction func cleanButton(_ sender: UIButton) {
        view.endEditing(true)
        //所有TextField.text清除
        //十進位DD經緯度TextField
        DDOfLatitude.text = ""
        DDOfLongtude.text = ""
        
        DDMOfLatiude.text = ""
        DDMOfLongitude.text = ""
        DDMOfMinuteLatitude.text = ""
        DDMOfMinuteLongitude.text = ""
        
        DMSOfLatitude.text = ""
        DMSOfLongitude.text = ""
        DMSOfMinuteLatitude.text = ""
        DMSOfMintueLongitude.text = ""
        DMSOfSecondLattude.text = ""
        DMSOfSecondLongitude.text = ""
        
        MarkTextField.text = ""

        MapMKMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.973875, longitude: 120.982026), latitudinalMeters: 450000, longitudinalMeters: 450000)
    }
    
    
}
