--Picking Report WH wise

select cast(dbo.tobdt(tt.CreatedOn) as smalldatetime) PickingTime,pv.Name Product, e.badgeid,e.fullname EmployeeName,
 count(*) Quantity, Sh.name ShelfName
from ThingTransaction tt
join ThingEvent te on te.ThingTransactionId=tt.id
join thing t on t.id=te.thingid
join employee e on e.id=tt.CreatedByCustomerId
Join ProductVariant PV On PV.Id=t.ProductVariantId
left Join shelf sh on sh.id=t.shelfid
--join warehouse w on w.id=e.warehouseid
where 
triggeringaction in (12,20,19)
and e.DesignationId=51
and e.terminatedon is null
and tt.CreatedOn >='2021-11-24 00:00 +06:00'
and tt.CreatedOn <'2021-11-25 00:00 +06:00'
and ProductVariantId in (4270)
and te.warehouseid=5
group by pv.Name,e.badgeid,e.fullname,cast(dbo.tobdt(tt.CreatedOn) as smalldatetime),Sh.name
order by 1 asc, 4 desc




