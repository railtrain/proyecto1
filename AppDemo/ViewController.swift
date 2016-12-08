//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 05/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, detalleViewControllerDelegate, agregarViewControllerDelegate {
    
    var rootRef : FIRDatabaseReference?
    
    
    @IBOutlet weak var imgfoto: UIImageView!
    
    @IBOutlet weak var lblfacenombre: UILabel!
    
    
    var datos = [("alvaro", 20),("erick", 34),("kaido", 36)]
    var esEdicion = false
    var arreglo : [(nombre: String, edad: Int, genero: String, foto: String)] = []
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
        //arreglo.append((nombre: "José", edad: 30, genero: "h", foto: ""))
      
        rootRef = FIRDatabase.database().reference()
        sincronizar()

        
        print("vista cargada")
        
        imgfoto.image = UIImage(named: "descarga")
        lblfacenombre.text = "firulais"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.rootRef!.child("base").observe(.value, with: { (snap: FIRDataSnapshot) in
            
            self.lblfacenombre.text = "\(snap.value!)"
            
            
        })
        
        
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
        return arreglo.count
    }
    func sincronizar (){
        let url = URL(string: "http://kke.mx/demo/contactos.php")
        var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1000)
            request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
            guard (error == nil) else {
                print("ocurrio un error con la peticion: \(error)")
                return
                }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else{
                print ("Ocurrio un error con la respuesta.")
                return
                }
            if (!(statusCode >= 200 && statusCode <= 299)){
                print("Respuestano valida")
                return
                }
            let cad = String(data: data!, encoding: .utf8)
                print("Response: \(response!.description)")
                print("error: \(error)")
            print("data: \(cad!)")
            var parsedResult: Any!
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            }catch{
                parsedResult = nil
                print("Error: \(error)")
                return
            }
            guard let dat = (parsedResult as? Dictionary<String, Any?>)?["datos"] as! [Dictionary<String, Any>]! else{
                print("Error: \(error)")
                return
            }
            self.arreglo.removeAll()
            
            for d in dat {
                let nombre = (d["nombre"] as! String)
                let edad = (d["edad"] as! Int)
                let foto = d["foto"] as! String
                let genero = d["genero"] as! String
                self.arreglo.append((nombre: nombre, edad: edad, genero: genero, foto: foto))
                
            }
            self.tbltabla.reloadData()

            })
        task.resume()
        
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
        

        let vista = tableView.dequeueReusableCell(withIdentifier: "proto1") as! filaTableViewCell
        
        //view.imgFoto.loadPicture(url: "http://kke.mx/demo/img/user_male.png")
        //view.imgFoto.downloadData(url: "http://kke.mx/demo/img/user_male.png")
        
        let dato = arreglo[indexPath.row];
        
        vista.lblizq.text = "\(dato.nombre)"
        vista.lblder.text = "\(dato.edad)"
        
        if dato.genero == "m" {
            vista.imgfotofila.image = UIImage(named: "user_female")
        } else {
            vista.imgfotofila.image = UIImage(named: "user_male")
        }
        
        vista.imgfotofila.downloadData(url: dato.foto)
        /*
         view.imgFoto.loadPicture(url: dato.foto)
         */
        
        return vista
    
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fila\(indexPath.row)")
        //detalle segue
        
        (performSegue(withIdentifier: "detalle sigue", sender: self))
    }
    @IBAction func btnrefresh(_ sender: Any) {
        let idFacebook = FBSDKAccessToken.current().userID
        let valor = Int(lblfacenombre.text!)!
        rootRef?.child("base").setValue(valor + 1)
        
        
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

