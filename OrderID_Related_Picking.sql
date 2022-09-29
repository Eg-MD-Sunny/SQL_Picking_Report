--Order ID Related Picking Data

select cast(dbo.tobdt(tt.CreatedOn) as smalldatetime) Date,
       e.badgeid,
	   d.DesignationName Designation,
	   e.fullname EmployeeName,
       pv.id PVID,
	   pv.name Product,
	   count(distinct t.ProductVariantId) No_Of_Item,
	   te.warehouseid,
	   w.name Warehouse
	   

from ThingTransaction tt
join ThingEvent te on te.ThingTransactionId=tt.id
join thing t on t.id=te.thingid
join employee e on e.id=tt.CreatedByCustomerId
join Designation d on d.Id = e.DesignationId 
join ProductVariant pv on pv.id=t.ProductVariantId
join warehouse w on w.id=te.WarehouseId
join ThingRequest tr on t.Id = tr.AssignedThingId 
join Shipment s on s.Id = tr.ShipmentId 

where 
triggeringaction in (12,20,19)
and tt.CreatedOn >='2022-01-28 00:00 +6:00'
and tt.CreatedOn <'2022-01-29 00:00 +6:00'
and s.OrderId in (7397100)

group by e.badgeid,
         e.fullname,
		 cast(dbo.tobdt(tt.CreatedOn) as smalldatetime),
		 te.WarehouseId,
		 w.name,
		 pv.id,
		 pv.name,
		 d.DesignationName