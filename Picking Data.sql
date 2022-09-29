-- Picking

select cast(dbo.tobdt(tt.CreatedOn) as smalldatetime) Date,
       e.badgeid,
	   d.DesignationName Designation,
	   e.fullname EmployeeName,
	 --s.OrderId [OrderID],
       pv.id PVID,
	   pv.name Product,
	   sl.Name [ShelfName],
	   count(t.ProductVariantId) No_Of_Item,
	   te.warehouseid,
	   w.name Warehouse
	   

from ThingTransaction tt
join ThingEvent te on te.ThingTransactionId=tt.id
join thing t on t.id=te.thingid
left join employee e on e.id=tt.CreatedByCustomerId
left join Designation d on d.Id = e.DesignationId 
join ProductVariant pv on pv.id=t.ProductVariantId
left join warehouse w on w.id=te.WarehouseId
join Shelf sl on sl.WarehouseId = w.id
--join ThingRequest tr on t.Id = tr.AssignedThingId 
--join Shipment s on s.Id = tr.ShipmentId


where triggeringaction in (12,20,19)
--and e.DesignationId=51
--and e.terminatedon is null
and pv.id in (36271)
--and w.id in (8)
and tt.CreatedOn >='2022-09-01 00:00 +6:00'
and tt.CreatedOn <'2022-09-13  00:00 +6:00'
--and e.BadgeId in (10706)

group by cast(dbo.tobdt(tt.CreatedOn) as smalldatetime),
         e.badgeid,
	     d.DesignationName,
	     e.fullname,
	--   s.OrderId,
         pv.id,
	     pv.name,
	     te.warehouseid,
	     w.name,
		 sl.Name

order by 1 



