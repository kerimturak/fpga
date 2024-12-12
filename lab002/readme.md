# Leading Ones

## Unique

![alt text](image.png)

![alt text](image-12.png)

Unique ifadesini kullandığımızda fpga'deki kaynak kullanımımız azaldı. Aynı şekilde ASIC'te de bu optimizasyonu bekleriz.

Fakat inputların one-hot geleceğinin garanti olduğu sistemlerde bu tasarım iyidir. Aksi taktirde birden fazla bitin aynı anda high olması
Tasarımın hatalı çalışmasına neden olacaktır.

## Without Unique

![alt text](image-1.png)

![alt text](image-13.png)

Unique olmadan bütün devre optimize edilmeden sentezlenir. Sentezlenen devre one-hot input beklemez aksine en yüksek bitin priority'si yüksek olduğundan leading one doğru şekilde bulunur.

## Down For

![alt text](image-2.png)

![alt text](image-14.png)

Break burada loop roll-up olabilecekse kullanmak mantıklıdır. Aslında en mantıklı çözüm break yerine kullanılacak bir yöntem varsa onu seçmektir. Çünkü sentez toolu for loop'u açarak priority yapısını sentezler. Eğer devre karışıksa sentez tool'u break ifadesini doğru sentezleyemeyebilir.

## Up For

![alt text](image-3.png)

![alt text](image-11.png)

Bu yapı break kullanmadan aynı loop devresini yazmanın bir yoludur. always_comb trigger'landığında hep led değeri en son sw'in gösterdiği değere göre güncellenir. always_comb'um procedural çalışma mekanizması sayesinde bu devre rahatlıkla çalışır.

Genele baktığımızda amaç leading one'dan binary yapıya geçmek, ilk durum ise one hot leading yapıdan binary karşılığına geçiyor.

# PULP Platform lzc Module

![alt text](image-9.png)

![alt text](image-10.png)

# Number of Ones

![alt text](image-4.png)

# Adder-Subtractor

## Adder
![alt text](image-5.png)

## Subtractor
![alt text](image-6.png)

# Multiplier
![alt text](image-7.png)

# Project-2
![alt text](image-8.png)