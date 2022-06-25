
import sys
from PyQt5.QtWidgets import QApplication,QMainWindow
from PyQt5 import uic
import mysql.connector  as sql
class myWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.basla()
        

    def basla(self):
        uic.loadUi(r"Z:\grup042_HIA\can\kayıtd.ui",self)
        self.show()
        self.lblDurum.setText("Bağlı Değil")
        self.ogrKayit.setEnabled(False)
        self.ogrenci_listele.setEnabled(False)
        self.kitap_kayit.setEnabled(False)
        self.btn_baglan.setEnabled(True)
        self.btn_kes.setEnabled(False)
        self.btn_baglan.clicked.connect(self.giris)
        self.btn_kes.clicked.connect(self.kes)
        self.btn_kaydet.clicked.connect(self.ogrenci_kayit)
        self.kayit_buton.clicked.connect(self.kitapKayit)
        self.listele_btn.clicked.connect(self.ogrenciListele)
    def baglan(self):
        self.db=sql.connect(user="root",host="127.0.0.1",password="",database="kutuphane")
        self.cursor=self.db.cursor()
        
    def giris(self):
        self.baglan()
        
        self.btn_baglan.setEnabled(False)
        self.btn_kes.setEnabled(True)
        self.lblDurum.setText("Bağlı")

        adi=self.txt_kullanici_adi.text()
        self.sifre=self.txt_sifre.text()

        querry="SELECT k_adi,sifre FROM kullanici"
        self.cursor.execute(querry)
        gelen=self.cursor.fetchall()

        for i in gelen:
            if adi==i[0] and self.sifre==i[1]:
                self.lblDurum.setText("Bağlı")
                self.ogrKayit.setEnabled(True)
                self.ogrenci_listele.setEnabled(True)
                self.kitap_kayit.setEnabled(True)
                
                
            
                
            
            else:
                self.lblDurum.setText("Kullanıcı adı veya şifre yanlış")
        self.sehir_getir()       
            
    def kes2(self):
        self.cursor.close()
        self.db.close()

    def kes(self):
        self.cursor.close()
        self.db.close()
        self.btn_baglan.setEnabled(True)
        self.btn_kes.setEnabled(False)
        self.lblDurum.setText("Bağlı değil...")
        self.ogrKayit.setEnabled(False)
        self.ogrenci_listele.setEnabled(False)
        self.kitap_kayit.setEnabled(False)
    def sehir_getir(self):
        querry="SELECT ID,adi FROM sehir;"
        self.cursor.execute(querry)
        querry=self.cursor.fetchall()
        for i in querry:
            self.sehir_box.addItem(str(i[0])+"-"+str(i[1]))
    def ogrenci_kayit(self):
        
        adi=self.adi_line.text()
        soyadi=self.soyadi_line.text()
        sehir=self.sehir_box.currentText()
        sehir=sehir.split("-")
        sehir=int(sehir[0])
        self.baglan()
        querry=f"INSERT INTO ogrenci (adi,soyadi,sehir_Id) VALUES ('{adi}','{soyadi}','{sehir}');"
        self.cursor.execute(querry)
        self.db.commit()
        self.kes2()
        self.adi_line.setText("")
        self.soyadi_line.setText("")
    def kitapKayit(self):
        adi=self.kitap_adi.text()
        yazar=self.kitap_yazar.text()
        self.baglan()
        querry=f"INSERT INTO kitap(adi,yazar) VALUES ('{adi}','{yazar}');"
        self.cursor.execute(querry)
        self.db.commit()
        self.kes2()
        self.kitap_adi.setText("")
        self.kitap_yazar.setText("")
    def ogrenciListele(self):
        self.baglan()
        querry="SELECT ogrenci.adi,ogrenci.soyadi,sehir.adi FROM ogrenci INNER JOIN sehir ON sehir.Id=ogrenci.sehir_Id;"
        self.cursor.execute(querry)
        sonuc=self.cursor.fetchall()
        self.kes2
        for i in sonuc:
            self.ogrenci_listesi.addItem(str(i))
    


        

app=QApplication(sys.argv)
ogr=myWindow()
sys.exit(app.exec_())