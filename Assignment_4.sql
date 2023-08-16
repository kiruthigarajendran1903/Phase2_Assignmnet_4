if exists (select name from sys.databases Where name = 'Assesment04Db')

drop database Assesment04Db

create database Assesment04Db

create table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float not null,
PTax as PPrice*0.10 persisted,
PCompany nvarchar(100) not null default 'Samsung',
PQty int check (PQty>=1) default 10
)


 insert into Products (PName,PPrice,PCompany) values('Mobile A', 15000, 'SamSung')
 insert into Products (PName,PPrice,PCompany)values('Mobile B', 200000, 'Apple')
 insert into Products (PName,PPrice,PCompany)values('Mobile C', 15000, 'Redmi')
 insert into Products (PName,PPrice,PCompany)values('Laptop A', 38000, 'Dell')
 insert into Products (PName,PPrice,PCompany)values('Laptop B', 42000, 'HP')
 insert into Products (PName,PPrice,PCompany)values('Mobile D', 25000, 'SamSung')
 insert into Products (PName,PPrice,PCompany)values('Laptop C', 28000, 'Lenovo')
 insert into Products (PName,PPrice,PCompany)values('Mobile E', 76800, 'Apple')
 insert into Products (PName,PPrice,PCompany)values('Laptop D', 38000, 'Acer')
 insert into Products (PName,PPrice,PCompany)values('Laptop E', 39600, 'Asus')

 create proc usp_PDetails
 as 
 select PId,PName,PPrice,PTax,PPrice+PTax as PPricewithTax,PCompany,((PPrice+PTax)*PQty) as TotalPrice from Products

 exec usp_PDetails

 alter proc usp_PDetails
 with encryption
  as 
 select PId,PName,PPrice,PTax,PPrice+PTax as PPricewithTax,PCompany,((PPrice+PTax)*PQty) as TotalPrice from Products


 exec sp_helptext usp_PDetails


  create proc usp_TotalTax
  @pcomapny nvarchar(50),
  @totaltax float
  as
  select @totaltax=sum(PTax) from Products where PCompany=@pcomapny


	alter proc usp_TotalTax
	 @pcomapny nvarchar(50),
  @totaltax float output
  with encryption
  as
  select @totaltax=sum(PTax) from Products where PCompany=@pcomapny 
  
    exec  usp_TotalTax 'HP',480000.23
    
  declare @TTax float
 exec usp_TotalTax 'HP' , @totaltax=@TTax output
 print @TTax

 exec usp_TotalTax 'Dell', 670000.67
 declare @TTax1 float
 exec usp_TotalTax 'SamSung' ,@TTax1 output
print @TTax1

 