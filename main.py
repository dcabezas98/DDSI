import pymysql as mdb
import sys

class App(object):

   def __init__(self, ip, user, passwd, db):

# Menú de la interfaz de texto
      self.mainMenu='''\n    Videoclub:    
------------------
0: Salir.
1: Dar de alta un socio.
2: Dar de baja un socio.
3: Cerrar un alquiler.
4: Consultar DVDs para una película.
5: Consultar turnos de un empleado.
------------------
Elija una opción: '''


# Datos para conectarse a la base de datos
      self.ip = ip
      self.user = user
      self.passwd = passwd
      self.db = db

      self.query = ''

      connection = mdb.connect(self.ip, self.user, self.passwd, self.db)
      self.cursor = connection.cursor()

   
   def altaSocio(self):
      nombre=input('Inserte nombre y apellidos del socio: ')
      while len(nombre)<=0 or len(nombre)>60:
         nombre=input('Debe tener entre 1 y 60 caracteres. \nInserte nombre y apellidos del socio: ')
         
      dni=input('Inserte DNI del socio: ')
      while len(dni)!=9:
         dni=input('Debe tener 9 caracteres. \nInserte DNI del socio: ')
      
      telefono=input('Inserte teléfono del socio: ')
      while len(telefono)!=9:
         telefono=input('Debe tener 9 caracteres. \nInserte teléfono del socio: ')
      
      domicilio=input('Inserte domicilio del socio: ')
      while len(domicilio)<=0 or len(domicilio)>=60:
         domicilio=input('Debe tener entre 1 y 60 caracteres. Inserte el domicilio del socio: ')
      
      diaNacimiento=input('Inserte dia de nacimiento del socio: ')
      while int(diaNacimiento)<1 or int(diaNacimiento) >31:
         diaNacimiento=input('Debe estar entre 1 y 31. Inserte dia de nacimiento del socio: ')
      
      mesNacimiento=input('Inserte mes de nacimiento del socio: ')
      while int(mesNacimiento)<1 or int(mesNacimiento) >12:
         mesNacimiento=input('Debe estar entre 1 y 12. Inserte mes de nacimiento del socio: ')
         
      anioNacimiento=input('Inserte año de nacimiento del socio: ')
      
      fechaNacimiento='-'.join([anioNacimiento,mesNacimiento,diaNacimiento])
      valores=', '.join(["'"+dni+"'","'"+nombre+"'","'"+telefono+"'","'"+domicilio+"'","DATE('" + fechaNacimiento + "')"])
      self.query='INSERT INTO Socio VALUES (' + valores + ');'
      
      self.executeQuery()
      self.cursor.execute("commit;")
      
      
   def cerrarAlquiler(self):
      dni=input('Inserte DNI del socio: ')
      while len(dni)!=9:
         dni=input('Debe tener 9 caracteres. \nInserte DNI del socio: ')
         
      cod=input('Inserte el código del DVD alquilado: ')
      while len(cod)!=9:
         cod=input('Debe tener 9 caracteres. \nInserte el código del DVD alquilado: ')
         
      # Sólo puede haber un alquiler abierto con ese código y ese DNI
      fecha = "STR_TO_DATE(DATE_FORMAT(SYSDATE(),'%Y-%m-%d'),'%Y-%m-%d')"
      self.query="UPDATE Alquiler SET fechaDevolucion=" + fecha + " WHERE DNI='"+dni+"' AND cod_DVD='"+cod+"' AND fechaDevolucion IS NULL;"
      
      self.executeQuery()
      self.cursor.execute("commit;");
      
   def consultarDVDs(self):
      titulo=input('Inserte título de la película: ')
      while len(titulo)<=0 or len(titulo)>=60:
         titulo=input('Debe tener entre 1 y 60 caracteres. Inserte título de la película: ')
         
      anio=int(input('Inserte el año de la película: '))
      
      self.query="SELECT * from DVD WHERE titulo='" + titulo + "' AND anio=" + str(anio) + ";"
      
      self.executeQuery()
      rows=self.cursor.fetchall()
      
      print()
      for r in rows:
         print(r)

   def consultarTurnos(self):
      dni=input('Inserte DNI del empleado: ')
      while len(dni)!=9:
         dni=input('Debe tener 9 caracteres. \nInserte DNI del empleado: ')
         
      self.query="SELECT * from Turno WHERE dni='" + dni + "';"
      
      self.executeQuery()
      rows=self.cursor.fetchall()
      
      print()
      for r in rows:
         print(r[0],' ',r[1].strftime("%m/%d/%Y"))
      
   def bajaSocio(self):
      dni=input('Inserte DNI del socio: ')
      while len(dni)!=9:
         dni=input('Debe tener 9 caracteres. \nInserte DNI del socio: ')
         
      self.query="DELETE from Socio WHERE DNI='" + dni + "';"
      
      self.executeQuery()
      self.cursor.execute("commit;");
      
   
      
      
   def executeQuery(self):
        print("Petición: " + self.query)
        return self.cursor.execute(self.query)
      
        
   def mainloop(self):

      while True:
         option = int(input(self.mainMenu))

         if option == 0:
            print('Hasta pronto.\t:D')
            exit()

         elif option == 1:
            self.altaSocio()

         elif option == 3:
            self.cerrarAlquiler()

         elif option == 4:
            self.consultarDVDs()

         elif option == 5:
            self.consultarTurnos()
            
         elif option == 2:
            self.bajaSocio()

         else:
            print('Opción no válida.')


# Main
if __name__=="__main__":
   ip = sys.argv[1]
   user = sys.argv[2]
   passwd = sys.argv[3]
   db = sys.argv[4]

   app = App(ip, user, passwd, db)
   app.mainloop()
   
   
