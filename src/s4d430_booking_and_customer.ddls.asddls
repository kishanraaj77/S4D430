@AbapCatalog.sqlViewName: 'S4D430_BOOKCUST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Join of Booking and Customer'
define view S4d430_Booking_And_Customer
  as select from S4D430_Booking  as b
    inner join   s4d430_Customer as c 
            on b.customid = c.id
{
  key b.carrid,
  key b.connid,
  key b.fldate,
  key b.bookid,
      b.customid,
      b.amount,
      b.currency,
      b.days_ahead,
      c.name,
      c.street,
      c.postcode,
      c.city,
      c.country
}
