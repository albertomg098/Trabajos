file.choose()
ruta_bd="C:\\Users\\alber\\OneDrive\\Documentos\\M�ster MII\\1�\\1� Cuatri\\Fuentes de energ�a\\Trabajo\\Irradiaci�n\\Base datos.xlsx"
datos_irrad=read_excel("C:\\Users\\alber\\OneDrive\\Documentos\\M�ster MII\\1�\\1� Cuatri\\Fuentes de energ�a\\Trabajo\\Irradiaci�n\\Base datos.xlsx")

names(datos_irrad)=c("LAT","LON","YEAR","MO","DY","Insolation_Clearness","Clear_Sky_Insolation","All_Sky_Insolation")

base_irradiacion=datos_irrad[datos_irrad$Clear_Sky_Insolation!=-999,]

#Contabilizaci�n de datos 
#meses
datos_irrad$MO=as.numeric(datos_irrad$MO)
n_datos=c(1,2,3,4,5,6,7,8,9,10,11,12)
mes=c("enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre")
k=1
for (i in 1:12) {
  n_datos[k]=nrow(filter(datos_irrad,datos_irrad$MO==i))
  k=k+1
}
cuenta_mes=data.frame(mes,n_datos)
write.table(cuenta_mes,file="cuenta_mes.csv",sep=",")

#a�o

datos_irrad$YEAR=as.numeric(datos_irrad$YEAR)
num_datos=c(1,2,3,4,5,6,7,8)
a�o=c(2013,2014,2015,2016,2017,2018,2019,2020)

h=1
for (i in 2013:2020) {
  num_datos[h]=nrow(filter(datos_irrad,datos_irrad$YEAR==i))
  h=h+1
}

cuenta_a�o=data.frame(a�o,num_datos)
write.table(cuenta_a�o,file="cuenta_a�o.csv",sep=",")

#Comparaci�n datos v�lidos vs err�neos

nrow(datos_irrad)
nrow(base_irradiacion)

nrow(datos_irrad)-nrow(base_irradiacion)
1-(nrow(base_irradiacion)/nrow(datos_irrad))


#C�lculo de medias y varianzas

#Mensual
base_irradiacion$Insolation_Clearness=as.numeric(base_irradiacion$Insolation_Clearness)
base_irradiacion$YEAR=as.numeric(base_irradiacion$YEAR)
base_irradiacion$MO=as.numeric(base_irradiacion$MO)

meses=c("enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre","TOTAL")
media_meses=c(1,2,3,4,5,6,7,8,9,10,11,12,13)
varianza_meses=c(1,2,3,4,5,6,7,8,9,10,11,12,13)

base_irradiacion$Insolation_Clearness=as.numeric(base_irradiacion$Insolation_Clearness)
g=1
for (i in 1:12) {
  media_meses[g]=mean(base_irradiacion[base_irradiacion$MO==i,]$Insolation_Clearness)
  varianza_meses[g]=var(base_irradiacion[base_irradiacion$MO==i,]$Insolation_Clearness)
  g=g+1
}

media_meses[13]= mean(base_irradiacion$Insolation_Clearness)
varianza_meses[13]=var(base_irradiacion$Insolation_Clearness)

MyV_mensual=data.frame(meses,media_meses,varianza_meses)



#Anual

a�os=c(2013,2014,2015,2016,2017,2018,2019,2020,"TOTAL")
media_a�o=c(1,2,3,4,5,6,7,8,9)
varianza_a�o=c(1,2,3,4,5,6,7,8,9)

p=1
for (i in 2013:2020) {
  media_a�o[p]=mean(base_irradiacion[base_irradiacion$YEAR==i,]$Insolation_Clearness)
  varianza_a�o[p]=var(base_irradiacion[base_irradiacion$YEAR==i,]$Insolation_Clearness)
  p=p+1
}

media_a�o[9]= mean(base_irradiacion$Insolation_Clearness)
varianza_a�o[9]=var(base_irradiacion$Insolation_Clearness)

MyV_anual=data.frame(a�os,media_a�o,varianza_a�o)

write.table(MyV_anual,file="MyV_anual.csv",sep = ",")
write.table(MyV_mensual,file="MyV_mensual.csv",sep = ",")



#Histogramas

#Mensuales

par(mfrow=c(1,1))
f=1
for (i in 1:12) {
  hist(base_irradiacion[base_irradiacion$MO==i,]$Insolation_Clearness,main=mes[f],xlab="Iradiaci�n")
  f=f+1
}

#Anuales

par(mfrow=c(1,1))
g=1
for (i in 2013:2020) {
  hist(base_irradiacion[base_irradiacion$YEAR==i,]$Insolation_Clearness,main=a�o[g],xlab="Iradiaci�n")
  g=g+1
}






