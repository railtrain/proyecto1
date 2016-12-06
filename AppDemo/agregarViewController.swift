//
//  agregarViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 06/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit
protocol agregarViewControllerDelegate{
    func agregarRegistro(nombre: String, edad: Int)

    
    func modificarRegistro(nombre: String, edad: Int, fila: Int)
    
}

class agregarViewController: UIViewController {

    @IBOutlet weak var txtnombre: UITextField!
    @IBOutlet weak var txtedad: UITextField!
    var delegado : agregarViewControllerDelegate? = nil
    var Nombre = ""
    var Edad = 0
    var fila = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func btnguardar(_ sender: Any) {
        if delegado != nil{
            
            if(txtnombre.text != nil && (txtnombre.text!.characters.count) > 0) && (txtedad.text != nil && (txtedad.text?.characters.count)! > 0)
                {
                    if fila == -1{
                        delegado?.agregarRegistro(nombre: txtnombre.text!, edad: Int (txtedad.text!)!)
                    }else{
                        delegado?.modificarRegistro(nombre: txtnombre.text!, edad: Int (txtedad.text!)!, fila: fila)
                    }
        
                    self.navigationController!.popViewController(animated: true)

                }else{
                var alert = UIAlertController(title: "Error", message: "los campos introducidos no son validos.", preferredStyle: .alert)
                var defaultAction = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                })
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
