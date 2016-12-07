//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 05/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, detalleViewControllerDelegate, agregarViewControllerDelegate {
    
    
    @IBOutlet weak var imgfoto: UIImageView!
    
    @IBOutlet weak var lblfacenombre: UILabel!
    
    
    var datos = [("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60),("alvaro",20),("erick",60)]
    var esEdicion = false
    
    func agregarRegistro(nombre: String, edad: Int){
        datos.append(nombre, edad)
        tbltabla.reloadData()
    }
    
    func modificarRegistro(nombre: String, edad: Int, fila: Int) {
        datos.remove(at: fila)
        datos.insert((nombre, edad), at: fila)
        tbltabla.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("vista cargada")
        
        imgfoto.image = UIImage(named: "descarga")
        lblfacenombre.text = "firulais"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func numeroCambiado(numero: Int) {
        print("Numero cambiado: \(numero)")
        datos[numero].1 = datos[numero].1 + 1
        tbltabla.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return datos.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexpath:
        IndexPath) -> [UITableViewRowAction]? {
        let eliminar = UITableViewRowAction(style: .destructive, title: "Borrar", handler: borrarFila)
        
        let editar = UITableViewRowAction(style: .normal, title: "editar", handler: editarFila)
        
        return [eliminar, editar]
    }
    func borrarFila(sender : UITableViewRowAction, indexPath : IndexPath){
        datos.remove(at: indexPath.row)
        tbltabla.reloadData()
    }
    func editarFila(sender : UITableViewRowAction, indexPath : IndexPath){
       esEdicion = true
        filaseleccionada = indexPath.row
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
       // let proto = (indexPath.row % 2 == 0) ? "proto1" : "proto2"
        
        let vista = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as! filaTableViewCell
      /*  vista.lblizq.text = "index"
        vista.lblder.text = "\(indexPath.row)"*/
        vista.lblizq.text = "\(datos[indexPath.row].0)"
        vista.lblder.text = "\(datos[indexPath.row].1)"
     
        let idFacebook = FBSDKAccessToken.current().userID
        let url = URL(string: "http://graph.facebook.com/829736847107787/picture?type=large")
        let dato: Data?
        
        do{
            dato = try Data(contentsOf: url!)
            vista.imgfotofila.image = UIImage(data: dato!)
        }catch {
            print("Error cargando la imagen.! \(error.localizedDescription)")
            dato = nil
            imgfoto.image = UIImage(named: "descarga")
        }
        
    
        return vista
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fila\(indexPath.row)")
        //detalle segue
        
        (performSegue(withIdentifier: "detalle sigue", sender: self))
    }
    @IBAction func btnrefresh(_ sender: Any) {
        let idFacebook = FBSDKAccessToken.current().userID
        
        
        let cadenaUrl =  "http://graph.facebook.com/829736847107787/picture?type=large"
      //  let dato: Data?
        imgfoto.loadPicture(url: cadenaUrl)
        
    }
    @IBAction func btnagregar_segue(_ sender: Any) {
        performSegue(withIdentifier: "agregar segue", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier!{
            case "detalle segue":
            let view = segue.destination as! detalleViewController
            view.numerofila = filaseleccionada
            view.dato = datos[filaseleccionada].0
            view.datoNumero = datos[filaseleccionada].1
            view.delegado =  self
            break
            case "agregar segue":
            let view = segue.destination as! agregarViewController
            view.delegado = self
            break
        default:
            break
        }
        
    }
    var filaseleccionada = -1
    
    @IBOutlet weak var tbltabla: UITableView!
    
    
}

