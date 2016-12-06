//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 05/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let datos = [("alvaro", 20),("erick", 60)]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("vista cargada")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return datos.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let proto = (indexPath.row % 2 == 0) ? "proto1" : "proto2"
        
        let vista = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as! filaTableViewCell
       // vista.lblizq.text = "index"
       // vista.lblder.text = "\(indexPath.row)"
        vista.lblizq.text = "\(datos[indexPath.row].0)"
        vista.lblder.text = "\(datos[indexPath.row].1)"
        return vista
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fila\(indexPath.row)")
    }
}

